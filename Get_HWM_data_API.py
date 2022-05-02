# -*- coding: utf-8 -*-
"""
Created on Fri Nov  5 10:57:37 2021

@author: lsgi_util_lab
"""

import os.path, time
import os
import datetime
import webbrowser
import csv
import re
import pandas as pd
import glob
import requests

        

def check_downloaded(data):
    if "Error" in data: 
        status = False
    else :
        status = True 
        
    return status
    


def download_data(info,gv):
#Input:mode: mode,T: time length,gv: gv number
#Process: Define the start and end time of data, and write the API string to get request
#Output: requested text of API
    mode = info.mode
    request_data_date_time = info.Timestamp
    if gv != "all": gv = "site:"+gv
    #request individual logger
    from datetime import datetime, timedelta

    
    
    

    
    if 9<=datetime.now().hour<24:
        
# HERE!!!!! Change 90 to 9 and 200 to 20 to enable it !!!!!!!!!!
        
        url = "http://59.148.216.10/datagate/api/DataExportAPI.ashx?format=csv&user=lsgi&pass=P@ssw0rd&logger="+gv+"&period=5&startdate="+request_data_date_time+"&enddate="+request_data_date_time+"&flowunits=1&pressureunits=1&enablestitching=True&interval=1"
    
    else: 
        url = ''
    
    r = requests.post(url)
    print (url)
    print (r.text)
    with open('readme.txt', 'w') as f:
        f.write(r.text)
    return r.text

def data_simulator(item):
    data = "Site,"+item+",s,s"+item+"\n"
    return data 
def open_file(lines,item):

    node_list = []
    if item != 'all':
        lines = data_simulator(item)+lines

    GV_data = lines.split("Site,")
    for each in GV_data:    
        if "GV" in each or "FM" in each:
            each = re.split(',|\*|\n|\r\n',each)
            
            node_list.append(each)
    return node_list
def format_date_for_arcgis(raw):
    y = raw[6:10]
    m = raw[3:5]
    d = raw[0:2]
    t = raw[11:]
    return (y+"-"+m+"-"+d+" "+t)

def date_filter(raw):
    y = raw[6:10]
    m = raw[3:5]
    d = raw[0:2]
    t = raw[11:]
    if (9<int(m)<20):
        return True 
    else: 
        return False 
        
    

def data_cleaning (node_list):
    date_time = []
    flow_pressure = []
    Flow_Rate = []
    GV = []

    time_index = []
    
    for each in node_list:
        epoch_number = (len(each)-8)/4
        if epoch_number>=1 :
            for i in range(int(epoch_number)):
                
                time_index.append(int(epoch_number)-i-1)
                raw_date = (each[7+(i)*4])
                formated_date = format_date_for_arcgis(raw_date)
                
                #change the date format from API respondes to fitting ArcGIS 
                date_time.append(formated_date)
                
                
                
                
                if (each[8+(i)*4]) != '' :
                    flow_pressure.append(float(each[8+(i)*4]))
                else:
                    flow_pressure.append(None)
                
                
                if (each[9+(i)*4]) != '' :
                    Flow_Rate.append(float (each[9+(i)*4]))
                else:
                    Flow_Rate.append(None)
                
                
                
                
                GV.append(each[0])
     
                
            
        else:
            print  ("Quite : " +str(each[0])+'\n')
                
    df = pd.DataFrame(list(zip(GV, date_time,flow_pressure,Flow_Rate,time_index)),
               columns =["GV","Time","flow_pressure","Flow_Rate","Update_Ranking"])
    
    df.to_csv('file_name.csv', encoding='utf-8')
    
    
    return df
    
def API_to_DF (info):
        # Input : mode: rt or simulated time
        N = 'all'
        print("Once")
        current_time = datetime.datetime.now()
        #'rt' mean get the data for a single time epoch, not a period 
        data = download_data(info,N)
        status = check_downloaded(data)
        if status:
            print ("ok")
        else: 
            print("Oh, there are errors so data is not available.")
            
        node_list = open_file(data,N)
        
        df = data_cleaning (node_list)
        print (df)    
        return df

    
    


def main():
# this part is for testing the above modules, will not be really used for operation

    x = 2
    while x ==1:
        current_time = datetime.datetime.now()
        if current_time.minute%5 ==0:
        
            download_data()
            time.sleep(40)
            file = check_downloaded(current_time)
            
            node_list = open_file(file)
            df = data_cleaning (node_list)
            print (df)
            time.sleep(20)
            
        else:
            time.sleep(30)
    
    if x ==2:
        df = API_to_DF('Simulated Time')
        print (data_request_info.Timestamp)


    
if __name__ == "__main__":
    data_request_info = data_request('','')
    main()
    
    
    
    

    
    

