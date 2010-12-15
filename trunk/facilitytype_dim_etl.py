import sys

# cesta k priecinku, kde sa nachadza podpriecinok pygrametl
sys.path.append('.') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='karty')

conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

query_target = 'TRUNCATE TABLE facilitytype'
conn_target.execute( query_target )
conn_target.commit()

# zdroj dat pre dimenziu
query_source = 'SELECT id, name, description FROM facilitytype'
facilitytype_source = SQLSource(connection=conn_source, query=query_source, names=(), initsql=None, cursorarg=None)

# dimenzia
facility_dim = CachedDimension(
    targetconnection = conn_target, 
    name='facilitytype', 
    key='id',
    attributes=['name', 'description'])

for row in facilitytype_source:
    facility_dim.insert(row)
    #print row
conn_target.commit()

conn_source.close()
conn_target.close()
