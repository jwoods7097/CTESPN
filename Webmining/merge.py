import pandas as pd

df1 = pd.read_excel("match_events_2023_07_15.xlsx")
df2 = pd.read_excel("match_events_2023_04_30.xlsx")
df3 = pd.read_excel("match_events_2023_04_16.xlsx")
df4 = pd.read_excel("match_events_2023_02_25.xlsx")

merged_df = pd.merge(df1, df2, how='outer')
merged_df = pd.merge(merged_df, df3, how='outer')
merged_df = pd.merge(merged_df, df4, how='outer')

merged_df.to_excel('match_events.xlsx')