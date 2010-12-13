import sys

# cesta k priecinku, kde sa nachadza podpriecinok pygrametl
sys.path.append('d:\\Marcel\\PDT\\dwh\\') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='jedalen')

## Define the MSSQL cursor objects
conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

# zdroj dat pre dimenziu jedlo, mena 

query_food_sales = 'SELECT cjm.id_cast_jedla_menu,cjm.cena,cjm.gramaz,cj.nazov,\
YEAR(p.cas),MONTH(p.cas),WEEK(p.cas),DAY(p.cas),sz.nazov,1 as facilitytype_id \
 FROM `jedalen`.`pohyb_na_ucte` p \
 left join jedalen.objednavka o using (id_objednavka) \
 left join jedalen.porcia por using (id_objednavka) \
 left join jedalen.cast_jedla_menu cjm using (id_cast_jedla_menu) \
 left join jedalen.cast_jedla cj using (id_cast_jedla) \
 left join jedalen.denne_menu dm on(cjm.id_denne_menu = dm.id_menu)\
 left join jedalen.stravovacie_zariadenie sz using (id_stravovacie_zariadenie)\
 limit 100'

food_sales_source = SQLSource(connection=conn_source, query=query_food_sales, names=('id', 'buy_price', 'weight', 'name','year','month','week','day','description','facilitytype_id'), initsql=None, cursorarg=None)

# Dimension and fact table objects
food_dim = CachedDimension(
    targetconnection = conn_target, 
    name='food', 
    key='id',
    attributes=['name', 'weight', 'buy_price'])
    
date_dim = CachedDimension(
    targetconnection = conn_target, 
    name='date', 
    key='id',
    attributes=['day', 'week', 'month','year'])
    
facility_dim = CachedDimension(
    targetconnection = conn_target, 
    name='facility', 
    key='id',
    attributes=['description','facilitytype_id'])

# zdroj dat pre dimenziu facility, tu sa to zacina komplikovat
### query_facility = 'SELECT w1.name, w1.description, w1., nazov FROM cast_jedla_menu w1, cast_jedla w2 WHERE w1.id_cast_jedla = w2.id_cast_jedla'
### facility_source = SQLSource(connection=conn_source, query=query_food, names=('id', 'buy_price', 'weight', 'name'), initsql=None, cursorarg=None)
### 
### facility_dim = CachedDimension(
###     targetconnection = conn_target, 
###     name='facility', 
###     key='id',
###     attributes=['name', 'description', 'FacilityType_id', 'Address_id'])
### 
### facility_type_dim = CachedDimension(
###     targetconnection = conn_target, 
###     name='facility_type', 
###     key='id',
###     attributes=['name', 'description'])
### 
### facility_sf = SnowflakedDimension(
###     [(facility_dim, (facility_type_dim))
###      ])

food_sales_fact = FactTable(
    targetconnection = conn_target,
    name='foodsale', 
    keyrefs=['profit', 'sale_price', 'food_id','facility_id','date_id'])

def main():
    i = 0
    # TODO pred vkladanim dat je potrebne spravit TRUNCATE na vsetky cielove tabulky
    # tak sa to robi, incremental load zrejme robit nebudeme :)
    conn_target.execute("delete from foodsale")
    conn_target.execute("delete from food")
    conn_target.execute("delete from `date`")
    conn_target.execute("delete from facility")
    conn_target.commit()
    for row in food_sales_source:
	i = i + 1
        print row
        # Transformacia, predajnu cenu som napevno stanovil ako 1.2 nasobok kupnej
        sale_price = row['buy_price'] * 1.2
        profit = sale_price - row['buy_price']
        row['profit'] = profit # Convert to an int
        row['sale_price'] = sale_price
        # Add the data to the dimension tables and the fact table
        row['food_id'] = food_dim.ensure(row)
        row['date_id'] = date_dim.ensure(row)
        row['facility_id'] = facility_dim.ensure(row)
        # na demonstraciu nepotrebujeme tych XYZ tisic dat co je v jedalni
        if i > 100:
            break
	food_sales_fact.insert(row)
    conn_target.commit()

if __name__ == '__main__':
    main()

