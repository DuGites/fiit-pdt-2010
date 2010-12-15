import sys
dir = sys.path[0]
# cesta k lib
sys.path.append(dir + '\\lib') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='karty')

mysql_conn_source.set_character_set('utf8')
mysql_conn_target.set_character_set('utf8')

conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

query = 'TRUNCATE TABLE facility'
conn_target.execute( query )
#query = 'TRUNCATE TABLE address'
#conn_target.execute( query )
conn_target.commit()

# zdroj dat pre dimenzie
query = 'SELECT id, address_city, address_street, adress_zip, address_state, name, description, facilitytype_id FROM facility'
facility_source = SQLSource(connection=conn_source, query=query, names=(), initsql=None, cursorarg=None)

# dimenzia
facility_dim = CachedDimension(
    targetconnection = conn_target, 
    name='facility', 
    key='id',
    attributes=['name', 'description', 'facilitytype_id', 'address_id'])

# dimenzia
address_dim = CachedDimension(
    targetconnection = conn_target, 
    name='address', 
    key='id',
    attributes=['address_city', 'address_street', 'address_zip', 'address_state'])

for row in facility_source:
    #oprava preklepu v nasej databaze
    row['address_zip'] = row['adress_zip']
    backup = row['id']
    # address si bude generovat vlastne id
    del row['id']
    # ensure nevlozi rovnaky riadok dvakrat a vracia hodnotu 'key'
    row['address_id'] = address_dim.ensure(row)
    # obnovime povodne id
    row['id'] = backup
    facility_dim.insert(row)
conn_target.commit()

conn_source.close()
conn_target.close()
