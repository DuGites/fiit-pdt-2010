import sys

# cesta k priecinku, kde sa nachadza podpriecinok pygrametl
sys.path.append('.') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='karty')

## Define the MSSQL cursor objects
conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

query_target = 'TRUNCATE TABLE facility'
conn_target.execute( query_target )
query_target = 'TRUNCATE TABLE address'
conn_target.execute( query_target )
conn_target.commit()

# zdroj dat pre dimenziu
query_source = 'SELECT id, address_city, address_street, adress_zip, address_state, name, description, FacilityType_id FROM facility'
facility_source = SQLSource(connection=conn_source, query=query_source, names=(), initsql=None, cursorarg=None)

# dimenzia
facility_dim = CachedDimension(
    targetconnection = conn_target, 
    name='facility', 
    key='id',
    attributes=['name', 'description', 'FacilityType_id', 'Address_id'])

# dimenzia
address_dim = CachedDimension(
    targetconnection = conn_target, 
    name='address', 
    key='id',
    attributes=['address_city', 'address_street', 'address_zip', 'address_state'])

# toto mi pride elegantnejsie
for row in facility_source:
    print row
    back = row['id']
    # address si bude generovat vlastne id
    del row['id']
    row['address_zip'] = row['adress_zip']
    # ensure nevlozi rovnaky riadok dvakrat a vracia hodnotu 'key'
    row['Address_id'] = address_dim.ensure(row)
    # obnovime povodne id
    row['id'] = back
    facility_dim.ensure(row)
conn_target.commit()

conn_source.close()
conn_target.close()
