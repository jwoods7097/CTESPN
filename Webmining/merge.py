import pandas as pd

df1 = pd.read_excel("match_events_2022_06_29.xlsx")
df2 = pd.read_excel("match_events_2022_02_26.xlsx")

merged_df = pd.merge(df1, df2, how='outer')

merged_df.to_excel('match_events_2022.xlsx')

df1 = pd.read_excel("matches_2022_06_29.xlsx")
df2 = pd.read_excel("matches_2022_02_26.xlsx")

merged_df = pd.merge(df1, df2, how='outer')

merged_df.to_excel('matches_2022.xlsx')

df1 = pd.read_excel("match_club_players_2022_06_29.xlsx")
df2 = pd.read_excel("match_club_players_2022_02_26.xlsx")

merged_df = pd.merge(df1, df2, how='outer')

merged_df.to_excel('match_club_players_2022.xlsx')