import sys
dir = sys.path[0]
# cesta k lib
sys.path.append(dir + '\\..\\lib') 

import MySQLdb

# vypise najziskovejsie jedalne za dany rok, default je 2008

db = MySQLdb.connect(host='localhost', user='root', passwd='', db='dwh')

db.set_character_set('utf8')

if (len(sys.argv) > 1):
    year = sys.argv[1]
else:
    year = '2008'
    
query = db.cursor()
report_source = 'select CONCAT(co.first_name," ",co.last_name) as name ,sum(fs.sale_price) from dwh.foodsale fs join dwh.card c on (fs.card_id = c.id) \
left join  dwh.cardowner co on (co.id = c.cardowner_id) \
left join `date` d on (fs.date_id = d.id) \
where year = %s \
group by (CONCAT(co.first_name," ",co.last_name)) \
order by (sum(fs.sale_price)) desc' %year

query.execute(report_source)
output = query.fetchall()
print "Suma;Meno"
for row in output:
    print "%s;%s" % (row[1],row[0])


