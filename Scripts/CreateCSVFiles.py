import pandas as pd

# columns_to_read = ['MatchID', 'Location', 'Date', 'Attendance']
# df = pd.read_excel('../RawData/matches_all.xlsx', usecols=columns_to_read)
# df['Location'] = df['Location'].str.replace(',', '')
# df['Attendance'] = df['Attendance'].str.replace('\"', '')
# df['Attendance'] = df['Attendance'].str.replace(',', '')
#
# df = df.drop_duplicates()
#
# df.to_csv('../Data/SQL/CSV/InfoForMatchTable.csv', index=False)
#
# columns_to_read = ['MatchID', 'Time', 'Commentary']
# df = pd.read_excel('../RawData/match_events_all.xlsx', usecols=columns_to_read)
#
# df = df.drop_duplicates()
#
# df.to_csv('../Data/SQL/CSV/InfoForMatchEventTable.csv', index=True)

club_mapping = {
    'ATL': 1,
    'ATX': 2,
    'CHI': 3,
    'CIN': 4,
    'CLB': 5,
    'CLT': 6,
    'COL': 7,
    'DAL': 8,
    'DC': 9,
    'HOU': 10,
    'LA': 11,
    'LAFC': 12,
    'MIA': 13,
    'MIN': 14,
    'MTL': 15,
    'NE': 16,
    'NSH': 17,
    'NY': 18,
    'NYC': 19,
    'ORL': 20,
    'PHI': 21,
    'POR': 22,
    'RSL': 23,
    'SEA': 24,
    'SJ': 25,
    'SKC': 26,
    'STL': 27,
    'TOR': 28,
    'VAN': 29
}

# df = pd.read_excel('../RawData/matches_all.xlsx')
#
# home_df = df[['MatchID', 'HomeClub', 'HomeFormation', 'HomeScore']].rename(columns={'HomeClub': 'Club', 'HomeFormation': 'Formation', 'HomeScore': 'Score'})
# home_df['MatchClubTypeID'] = 1
#
# away_df = df[['MatchID', 'AwayClub', 'AwayFormation', 'AwayScore']].rename(columns={'AwayClub': 'Club', 'AwayFormation': 'Formation', 'AwayScore': 'Score'})
# away_df['MatchClubTypeID'] = 2
#
# result_df = pd.concat([home_df, away_df], ignore_index=True)
#
# result_df = result_df[result_df['Club'].isin(club_mapping.keys())]
#
# result_df['ClubID'] = result_df['Club'].map(club_mapping).astype(int)
#
# result_df.drop('Club', axis=1, inplace=True)
#
# column_order = ['ClubID', 'MatchClubTypeID', 'MatchID', 'Formation', 'Score']
# result_df = result_df[column_order]
#
# result_df = result_df.drop_duplicates()
#
# result_df.to_csv('../Data/SQL/CSV/InfoForMatchClubTable.csv', index=True)


# players = pd.read_csv('../Data/SQL/CSV/InfoForPlayerTable.csv', header=None)
#
# players = players.rename(columns={0: 'PlayerID', 1: 'PlayerTypeID', 2: 'Name'})
#
# players.drop('Name', axis=1, inplace=True)
#
# mcp = pd.read_excel('../RawData/match_club_players_all.xlsx', usecols=['PlayerID', 'Club'])
#
# merged = pd.merge(players, mcp, on='PlayerID')
#
# merged['DateStarted'] = '2021-01-01'
#
# merged = merged[merged['Club'].isin(club_mapping.keys())]
#
# merged = merged.drop_duplicates()
#
# merged['ClubID'] = merged['Club'].map(club_mapping).astype(int)
# merged.drop('Club', axis=1, inplace=True)
#
# column_order = ['PlayerID', 'PlayerTypeID', 'ClubID', 'DateStarted']
# merged = merged[column_order]
#
# merged.to_csv('../Data/SQL/CSV/InfoForClubPlayerTable.csv', index=True)


# df = pd.read_excel('../RawData/match_club_players_all.xlsx')
#
# players = pd.read_csv('../Data/SQL/CSV/InfoForPlayerTable.csv', header=None)
#
# players = players.rename(columns={0: 'PlayerID', 1: 'PlayerTypeID', 2: 'Name'})
#
# players.drop('Name', axis=1, inplace=True)
#
# df = pd.merge(df, players, on='PlayerID')
#
# df = df[df['Club'].isin(club_mapping.keys())]
#
# df['ClubID'] = df['Club'].map(club_mapping).astype(int)
#
# df.drop('Club', axis=1, inplace=True)
# df.drop('Unnamed: 0.1', axis=1, inplace=True)
# df.drop('Unnamed: 0', axis=1, inplace=True)
# column_order = ['PlayerID', 'PlayerTypeID', 'MatchID', 'ClubID', 'SubstitutedForPlayer', 'SubstitutionTime', 'Played']
# df = df[column_order].drop_duplicates()
#
# df['Played'] = df['Played'].astype(int)
#
# df.to_csv('../Data/SQL/CSV/InfoForMatchClubPlayerTable.csv', index=True, index_label='MatchClubPlayerID')


position_map = {'G': 4, 'D': 3, 'M': 2, 'F': 1}


df = pd.read_csv('../Data/SQL/CSV/InfoForMatchClubPlayerTable.csv', usecols=['MatchClubPlayerID', 'PlayerID', 'PlayerTypeID', 'MatchID'])

stats = pd.read_excel('../RawData/All-Player-Stats.xlsx', header=0)

stats['PlayerTypeID'] = stats["Position"].map(position_map)
stats.drop("Position", axis=1, inplace=True)

merged = pd.merge(df, stats, on=['PlayerID', 'PlayerTypeID', 'MatchID'])
merged = merged[merged['PlayerTypeID'] != 4]
merged.drop("Name", axis=1, inplace=True)
merged.drop("PlayerID", axis=1, inplace=True)
merged.drop("MatchID", axis=1, inplace=True)
merged.drop("Year", axis=1, inplace=True)

column_order = ['MatchClubPlayerID', 'PlayerTypeID', 'Goals', 'Assists', 'Fouls', 'Offsides', 'Shots', 'ShotsOnTarget', 'YellowCards', 'RedCards']
merged = merged[column_order]

merged.to_csv('../Data/SQL/CSV/InfoForMatchOutfielderStats.csv', index=False)



df = pd.read_csv('../Data/SQL/CSV/InfoForMatchClubPlayerTable.csv', usecols=['MatchClubPlayerID', 'PlayerID', 'PlayerTypeID', 'MatchID'])

stats = pd.read_excel('../RawData/All-Player-Stats.xlsx', header=0, sheet_name='Goalkeepers')

stats['PlayerTypeID'] = stats["Position"].map(position_map)
stats.drop("Position", axis=1, inplace=True)

merged = pd.merge(df, stats, on=['PlayerID', 'PlayerTypeID', 'MatchID'])
merged = merged[merged['PlayerTypeID'] == 4]
merged.drop("Name", axis=1, inplace=True)
merged.drop("PlayerID", axis=1, inplace=True)
merged.drop("MatchID", axis=1, inplace=True)
merged.drop("Year", axis=1, inplace=True)
merged.drop("Clean_Sheets", axis=1, inplace=True)
merged.drop("Goals_Against", axis=1, inplace=True)
merged.drop("Goals", axis=1, inplace=True)
merged.drop("Assists", axis=1, inplace=True)
merged.drop("Fouls_Against", axis=1, inplace=True)
merged["RedCards"] = 0

merged.to_csv('../Data/SQL/CSV/InfoForMatchGoalkeeperStats.csv', index=False)
