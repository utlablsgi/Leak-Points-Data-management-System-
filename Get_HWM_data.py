# -*- coding: utf-8 -*-
"""
Created on Thu Oct 28 13:17:21 2021

@author: lsgi_util_lab
"""

import webbrowser

import datetime

import time
node_dictionary = {"GV80":15,"GV91":16,"GV69":46,"GV70":53}
node= ["GV80","GV91","GV69","GV70"]

def convert_GV_to_numberstring(node):
    stringline = ""
    for each in node:
        number = node_dictionary[each]
        
        if node.index(each)!=len(node)-1:
            stringline = stringline+str(number)+","
        else: 
            stringline = stringline+str(number)
    return stringline


def convert_GV_to_numberlist(node):
    number_list = []
    for each in node:
        number = node_dictionary[each]
        number_list.append(number)
        
    return number_list

def data_checking(header,node):
    status_list = []
    for each in node:
        child_list = []
        for each_item in header:
            
            if each in each_item:
                if "Pressure" in each_item:
                    child_list.append("P")
                elif "Flow" in each_item:
                    child_list.append("F")
        status_list.append(child_list)
        
    return status_list
            

def write_url(period,node_number):
    return
    
e = datetime.datetime.now()

print ("Current date and time = %s" % e)

print ("Today's date:  = %s/%s/%s" % (e.day, e.month, e.year))

print ("The time is now: = %s:%s:%s" % (e.hour, e.minute, e.second))

from_year = 2021
from_month = 10
from_day = 27
from_hour = 00
from_minute = 00


webbrowser.open("http://59.148.216.10/datagate/Secure/TrendExport.aspx?export=1&signals=15,16,46,53&period=custom&chunits=23,26|0&DemoMode=False&enablestitching=True&chartType=&useUtc=1&fyear=2021&fmonth=10&fday=20&fhour=16&fmin=15&tyear=2021&tmonth=10&tday=20&thour=16&tmin=15&uv=267&dt=1&int=1", new=0)


time.sleep(10)


import csv
second_now = str(e.minute)
if len(second_now) == 1:
    second_now= "0"+second_now
filename = "C:\\Users\\lsgi_util_lab\\Downloads\\_" +str(e.year)+str(e.month)+str(e.day)+str(e.hour)+str(second_now)+".csv"
file = open(filename)
type(file)
csvreader = csv.reader(file)
header = []
header = next(csvreader)

rows = []
i = 0
for row in csvreader:
        rows.append(row)
        i+=1


if len(rows) ==0:
    print ("Oh, there might have some quiet points.Please ensure that you have excluded the quiet points.")
   

else:
    date_time = []
    flow_pressure = []
    flow_velocity = []
    GV = []
    pressure_list = []
    flow_list = []
    GV_Amount = len(node)
    GV = (node)
    Pressure_location_list=[]
    Flow_location_list=[]
    for each in header:
        if "Pressure" in each:
            Pressure_location_list.append(header.index(each))
        if "C2 Flow" in each:
            Flow_location_list.append(header.index(each))
    for each in rows:
        
        for i in range(int (GV_Amount)):date_time.append(each[0])
        for i in Pressure_location_list:flow_pressure.append(float(each[i]))            
        for i in Flow_location_list:flow_velocity.append(float(each[i]))

    Pressure_Absent_list = []
    Flow_Absent_list = []
    quality_list = data_checking(header,node)
    for each in quality_list:
        if "P" not in each:
            Pressure_Absent_list.append(quality_list.index(each))
            print ("No pressure data for "+ node[quality_list.index(each)])
        if "F" not in each:
            Flow_Absent_list.append(quality_list.index(each))
            print ("No Velocity data for "+ node[quality_list.index(each)])
    for each in Pressure_Absent_list:
        flow_pressure.insert(each,-1000)
    for each in Flow_Absent_list:
        flow_velocity.insert(each,-1000)
import pandas as pd
df = pd.DataFrame(list(zip(GV, date_time,flow_pressure,flow_velocity)),
               columns =["GV","Last_update","flow_pressure","flow_velocity"])

print (df)
df.to_csv('file_name.csv', encoding='utf-8')