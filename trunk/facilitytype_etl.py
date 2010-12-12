import MySQLdb

mysql_conn_target = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')
mysql_conn_source = MySQLdb.connect(host='localhost', user='root', passwd='', db='karty')

curr_source = mysql_conn_source.cursor()
curr_target = mysql_conn_target.cursor()

query_target = 'TRUNCATE TABLE facilitytype'
curr_target.execute( query_target )
mysql_conn_target.commit()

query_source = 'SELECT id, name, description FROM facilitytype'
curr_source.execute( query_source )
for row in curr_source:
    query_target = 'INSERT INTO facilitytype (id, name, description) VALUES ("' + str(row[0]) + '", "' + str(row[1]) + '", "' + str(row[2]) + '")'
    curr_target.execute( query_target )
mysql_conn_target.commit()

curr_target.close()
curr_source.close()
mysql_conn_target.close()
mysql_conn_source.close()
