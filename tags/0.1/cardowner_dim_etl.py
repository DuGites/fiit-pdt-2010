# -*- coding: <utf-8> -*-

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

query = 'TRUNCATE TABLE cardowner'
conn_target.execute( query )
conn_target.commit()

# zdroj dat pre dimenziu
query = 'SELECT * FROM cardowner'
cardowner_source = SQLSource(connection=conn_source, query=query, names=(), initsql=None, cursorarg=None)

# dimenzia
cardowner_dim = CachedDimension(
    targetconnection = conn_target, 
    name='cardowner', 
    key='id',
    attributes=['first_name', 'last_name', 'title_before_name', 'title_after_name', \
                'date_of_birth', 'sex', 'birth_place', 'birth_number', 'id_card_number', 'id_card_type', \
                'photo', 'note', 'ownerrole_id', 'address_id'])

# dimenzia
address_dim = CachedDimension(
    targetconnection = conn_target, 
    name='address', 
    key='id',
    attributes=['address_city', 'address_street', 'address_zip', 'address_state'])

for row in cardowner_source:
    # mozete menit hodnoty
    row['ownerrole_id'] = row['OwnerRole_id']
    row['address_id'] = address_dim.ensure(row)
    #print row
    cardowner_dim.insert(row)
conn_target.commit()

conn_source.close()
conn_target.close()
