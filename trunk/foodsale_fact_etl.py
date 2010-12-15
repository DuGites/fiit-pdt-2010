import sys
dir = sys.path[0]
# cesta k lib
sys.path.append(dir + '\\lib') 

import pygrametl, MySQLdb, random, datetime
from pygrametl.datasources import *
from pygrametl.tables import *
from datetime import datetime

# Pripojenia na zdrojovu a cielovu databazu
mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='jedalen')

conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

# Vyprazdnenie cielovych tabuliek
query = 'TRUNCATE TABLE foodsale'
conn_target.execute( query )
query = 'TRUNCATE TABLE date'
conn_target.execute( query )
conn_target.commit()

# zdroj dat pre faktovu tabulku foodsale
query = 'SELECT id_porcia, id_cast_jedla_menu, id_objednavka FROM porcia'
foodsale_source = SQLSource(connection=conn_source, query=query, names=(), initsql=None, cursorarg=None)

# faktova tabulka foodsale
food_fact = FactTable(
    targetconnection = conn_target,
    name='foodsale', 
    keyrefs=['id', 'buy_price', 'weight', 'profit', 'sale_price', 'food_id','facility_id','date_id', 'card_id'])

# dimenzia datumu, tuto dimenziu nie je mozne naplnat samostatne
date_dim = CachedDimension(
    targetconnection = conn_target, 
    name='date', 
    key='id',
    attributes=['day', 'week', 'month','year', 'semester'])

i = 0
print datetime.now()
# naplnanie foodsale
for row in foodsale_source:
    i = i + 1
    # foodsale je 1 k 1 s porcia, preto mozeme pouzit ID
    row['id'] = row['id_porcia']
    query = 'SELECT gramaz, cena, id_stravovacie_zariadenie, id_cast_jedla FROM cast_jedla_menu, denne_menu WHERE id_denne_menu = id_menu AND id_cast_jedla_menu = %s LIMIT 1' %row['id_cast_jedla_menu']
    conn_source.execute(query)
    res = conn_source.fetchone()
    row['buy_price'] = res['cena']
    row['sale_price'] = res['cena'] * 1.2
    row['profit'] = row['sale_price'] - row['buy_price']
    row['weight'] = res['gramaz']
    row['food_id'] = res['id_cast_jedla']
    row['facility_id'] = res['id_stravovacie_zariadenie']
    query = 'SELECT YEAR(cas) as year ,MONTH(cas) as month ,WEEK(cas) as week,DAY(cas) as day, id_karta FROM konto k, pohyb_na_ucte p WHERE k.id_konto = p.id_konto AND id_objednavka = %s LIMIT 1' %row['id_objednavka']
    conn_source.execute(query)
    res = conn_source.fetchone()
    res['semester'] = None
    if res['month'] >= 9 and res['month'] <= 12:
        res['semester'] = '0'
    if res['month'] >= 2 and res['month'] <= 5:
        res['semester'] = '1'
    #keby sedeli idcka kariet v jedalni
    #row['card_id'] = res['id_karta']
    row['card_id'] = random.randint(106, 2430)
    row['date_id'] = date_dim.ensure(res)
    #print row
    food_fact.insert(row)
    if i > 1000:
        break
conn_target.commit()
print datetime.now()

conn_source.close()
conn_target.close()
