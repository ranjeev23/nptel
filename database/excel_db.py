import pandas as pd
import db_class
import math
# Initialize db connection
my_db_connect = db_class.mysql_connector(
    "localhost", "root", "password", "nptel_management"
)


df = pd.read_excel('/Users/ranjeevramprasad/Documents/ranjeev_college/nptel/23-april/nptel_app 2/extras/2_ NPTEL Results Jul to Oct-Final-IT-NOV2021 3.xlsx')

df_values = df.values
df_values = df_values[:, :-1].tolist()

counter = 1
for values in df_values:
    if math.isnan(values[0]):
        print('broke',values)
        break
    else:
        print(values[0],counter)
        counter+=1
print(counter)

df_values = df_values[:counter-1]

my_db_connect.ins_std_table(df_values)

print(df_values)