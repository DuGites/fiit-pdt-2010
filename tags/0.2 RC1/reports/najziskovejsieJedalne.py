import sys
dir = sys.path[0]
# cesta k lib
sys.path.append(dir + '\\..\\lib') 

import MySQLdb

# vypise najpredavanejsie jedla za rok v parametri (default je 2008)

db = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')

db.set_character_set('utf8')

if (len(sys.argv) > 1):
    year = sys.argv[1]
else:
    year = '2008'
    
query = db.cursor()
report_source = "select sum(profit),f.name from dwh.foodsale fs \
join dwh.facility f on (f.id = fs.facility_id) \
join `date` d on (fs.date_id = d.id) \
where d.year = %s \
group by (f.id) order by sum(profit) desc" % year

query.execute(report_source) 
output = query.fetchall()
print "jedalen;zisk"
for row in output:
    print "%s;%s" % (row[1],row[0])



