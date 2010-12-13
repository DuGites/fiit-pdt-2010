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

query_target = 'TRUNCATE TABLE card'
conn_target.execute( query_target )
conn_target.commit()

# zdroj dat pre dimenziu
query_source = 'SELECT * FROM card'
card_source = SQLSource(connection=conn_source, query=query_source, names=(), initsql=None, cursorarg=None)

# dimenzia
card_dim = CachedDimension(
    targetconnection = conn_target, 
    name='card', 
    key='id',
    attributes=['card_number', 'serial_number', 'validity_date_from', 'validity_date_to', \
                'sale_date', 'void_date', 'facility_id', 'cardowner_id', 'producttype_id', 'organization_id'])

# toto mi pride elegantnejsie
for row in card_source:
    #print row
    # mozete menit hodnoty
    ### row['id'] = i
    row['facility_id'] = row['Facility_id']
    row['cardowner_id'] = row['CardOwner_id']
    row['producttype_id'] = row['ProductType_id']
    row['organization_id'] = row['Organization_id']
    card_dim.insert(row)
conn_target.commit()

conn_source.close()
conn_target.close()
