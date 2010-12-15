import sys

# cesta k priecinku, kde sa nachadza podpriecinok pygrametl
sys.path.append('.') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='karty')

mysql_conn_source.set_character_set('utf8')
mysql_conn_target.set_character_set('utf8')

conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

query = 'TRUNCATE TABLE card'
conn_target.execute( query )
conn_target.commit()

# zdroj dat pre dimenziu
query = 'SELECT * FROM card'
card_source = SQLSource(connection=conn_source, query=query, names=(), initsql=None, cursorarg=None)

# dimenzia
card_dim = CachedDimension(
    targetconnection = conn_target, 
    name='card', 
    key='id',
    attributes=['card_number', 'serial_number', 'validity_date_from', 'validity_date_to', \
                'sale_date', 'void_date', 'facility_id', 'cardowner_id', 'producttype_id', 'organization_id'])

for row in card_source:
    # rozdiely v malych a velkych pismenach
    row['facility_id'] = row['Facility_id']
    row['cardowner_id'] = row['CardOwner_id']
    row['producttype_id'] = row['ProductType_id']
    row['organization_id'] = row['Organization_id']
    #print row
    card_dim.insert(row)
conn_target.commit()

conn_source.close()
conn_target.close()
