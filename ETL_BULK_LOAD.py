import os
import time
import sys
import datetime
from threading import Thread
from datetime import datetime

class etl_thread(Thread):
    def __init__ (self, dir, etl_file):
        Thread.__init__(self)
        self.etl_file = etl_file
        self.dir = dir
        self.status = -1
    def run(self):
        self.status = 0
        print 'ETL %s started. ' %self.etl_file + str(datetime.now())
        os.system(self.dir + '\\' + self.etl_file)
        print 'ETL %s finished. ' %self.etl_file + str(datetime.now())
        self.status = 1

dir = sys.path[0]
etl_scripts = ['foodsale_fact_etl.py', 'cardowner_dim_etl.py', 'card_dim_etl.py', 'food_dim_etl.py', 'facility_dim_etl.py', 'facilitytype_dim_etl.py']
etl_threads = []
print 'ETL START'
print datetime.now()
for etl_script in etl_scripts:
    current = etl_thread(dir, etl_script)
    etl_threads.append(current)
    current.start()
    
stop = 1
while stop == 1:
    stop = 0
    time.sleep(0.5)
    for etl_thread in etl_threads:
        if etl_thread.status <> 1:
            stop = 1
print 'ETL END'
print datetime.now()
