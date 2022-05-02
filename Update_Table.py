
#import the required modules
import arcpy 
import os.path, time
import datetime
from datetime import timedelta
import Get_HWM_data_API
from datetime import datetime, timedelta

def ScriptTool(df,GVN,item): 
#Input: "df","GVN"| dataframe storing the sensor data, shapefile of the GV| dataframe,string
#Function: update the value of table
#Output: NULL
    now_date_time = datetime.now()
    fc = GVN 
    fields = ["Name",'Flow_Pressure', 'Flow_Rate',"Data_Time","Last_Update"]  
    ndf = get_updated_list(df)   
    with arcpy.da.UpdateCursor(fc, fields) as cursor:
        
        for row in cursor: 
           
            ID = row[0]
            line = ndf.loc[ (ndf['GV'] == ID)]
            if list(line['flow_pressure']) !=[]:
                    
                try:       
                    row[1] = float(list(line["flow_pressure"])[0])
                except: 
                    row[1] = None
                try:
                    
                    row[2] = float(list(line["Flow_Rate"])[0])
                except: 
                    row[2] = None
        
                row[3] = str(list(line["Time"])[0])
                        
                row[4] = str(now_date_time.strftime('%Y-%m-%d %H:%M'))
        
               
            else:
                row[1] = None
        
                row[2] = None
        
                row[3] =str(data_request_info.Timestamp)+ ' (Quite)'
                        
                row[4] = str(now_date_time.strftime('%Y-%m-%d %H:%M'))
         
            cursor.updateRow(row)
            
 
    return 
def Update_Summary(info,table): 
#Input: "df","GVN"| dataframe storing the sensor data, shapefile of the GV| dataframe,string
#Function: update the value of table
#Output: NULL
    
    fc = table 
    fields = ["Current_Mode",'Request_Submit_Time', 'API_String']  
    
    with arcpy.da.UpdateCursor(fc, fields) as cursor:
        
        for row in cursor: 
           
            
            
            row[0] = info.mode
                        
            row[1] = info.time_request
        
         
            cursor.updateRow(row)
            
 
    return 

def convert_to_UTC(local_t):
#Input: "local_t",|
    for i in range(len(df.index)):
        local_t.at[i,'Time']=datetime.datetime.strptime(df.at[i,'Time'],'%d-%m-%Y %H:%M')- timedelta(hours = 8)
        
    return local_t

def get_updated_list(df): 
#Input: "df"|dataframe of the unfiltered data| dataframe
#Function: Select the most updated data in a datafram if there are data for more than one epoch
#Output:"updated_line"| dataframe contains only the most updated epoch
    updated_line = df.loc[ (df['Update_Ranking'] == 0)]
    return updated_line

class data_request:

            def __init__(self, Timestamp,mode):
                self.Timestamp = Timestamp
                self.mode = mode
                self.time_request = str(datetime.now().strftime('%Y-%m-%d+%H:%M'))
if __name__ == '__main__':
        mode = arcpy.GetParameterAsText(0)
        item = arcpy.GetParameterAsText(1)
        GVN = "https://services8.arcgis.com/qjxJfgMvSVokBJDh/arcgis/rest/services/GV_Node/FeatureServer/0"
        summary_table = "https://services8.arcgis.com/qjxJfgMvSVokBJDh/arcgis/rest/services/Summary_Table_for_GV_update/FeatureServer/0"
        now_date_time = datetime.now()- timedelta(minutes = 10)
        if mode =="Simulated Time" :
       
        
            SIM_date_time = now_date_time - timedelta(hours = 240) 
            SIM_END = SIM_date_time
            starttime = str(SIM_date_time.strftime('%Y-%m-%d+%H:%M'))
            endtime = str(SIM_END.strftime('%Y-%m-%d+%H:%M'))
            
        else: 
         
            SIM_date_time = now_date_time
            SIM_END = SIM_date_time
            starttime = str(SIM_date_time.strftime('%Y-%m-%d+%H:%M'))
            endtime = str(SIM_END.strftime('%Y-%m-%d+%H:%M'))
    
       
        data_request_info = data_request(endtime,mode)
        df = Get_HWM_data_API.API_to_DF(data_request_info)
        df.to_csv('df.csv', encoding='utf-8')
        ScriptTool(df,GVN,item) 
        Update_Summary(data_request_info,summary_table)
        #the system will remove the raw data file downloaded before to save storage space
    


        

