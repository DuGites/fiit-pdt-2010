import sys
dir = sys.path[0]
# cesta k lib
sys.path.append(dir + '\\lib') 

import pygrametl, MySQLdb
from pygrametl.datasources import *
from pygrametl.tables import *

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='jedalen')

mysql_conn_source.set_character_set('utf8')
mysql_conn_target.set_character_set('utf8')

conn_source = pygrametl.ConnectionWrapper(mysql_conn_source)
conn_target = pygrametl.ConnectionWrapper(mysql_conn_target)

query_target = 'TRUNCATE TABLE food'
conn_target.execute( query_target )
conn_target.commit()

# zdroj dat pre dimenziu, food je 1 k 1 s cast_jedla
query_source = 'SELECT id_cast_jedla, nazov FROM cast_jedla'
food_source = SQLSource(connection=conn_source, query=query_source, names=('id','name'), initsql=None, cursorarg=None)

# dimenzia
food_dim = CachedDimension(
    targetconnection = conn_target, 
    name='food', 
    key='id',
    attributes=['name'])

# toto mi pride elegantnejsie
for row in food_source:
    #print row
    food_dim.insert(row)
conn_target.commit()

conn_source.close()
conn_target.close()
