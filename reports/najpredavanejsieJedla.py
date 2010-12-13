import MySQLdb
import sys

# vypise najpredavanejsie jedla za rok v parametri (default je 2008)

db = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')

if (len(sys.argv) > 1):
    year = sys.argv[1]
else:
    year = '2008'
    
query = db.cursor()
report_source = 'select count(*),f.name from dwh.food f \
join dwh.foodsale fs on (f.id = fs.food_id) \
join dwh.`date` d on (fs.date_id = d.id) \
where d.year = %s group by f.name order by count(*) desc' % year

query.execute(report_source) 
output = query.fetchone()
print output 




