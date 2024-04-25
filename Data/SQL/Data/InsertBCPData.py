import os

player_file_path = 'Data\SQL\CSV\InfoForPlayerTable.csv'
create_player = f'bcp CTESPN.MLS.Player in "{player_file_path}" -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Player.fmt'

try:
    os.system(create_player)
except Exception as e:
    print(e)

goalkeeper_file_path = 'Data\SQL\CSV\InfoForGoalkeeperTable.csv'
extract_goalkeepers = f'bcp "SELECT PlayerID, PlayerTypeID FROM CTESPN.MLS.Player WHERE PlayerTypeID = 4" queryout {goalkeeper_file_path} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Goalkeeper.fmt'
create_goalkeeper = f'bcp CTESPN.MLS.Goalkeeper in "{goalkeeper_file_path}" -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Goalkeeper.fmt'

try:
    os.system(extract_goalkeepers)
    os.system(create_goalkeeper)
except Exception as e:
    print(e)

outfielder_file_path = 'Data\SQL\CSV\InfoForOutfielderTable.csv'
extract_outfielders = f'bcp "SELECT PlayerID, PlayerTypeID, CASE WHEN PlayerTypeID = 1 THEN N\'Forward\' WHEN PlayerTypeID = 2 THEN N\'Midfielder\' WHEN PlayerTypeID = 3 THEN N\'Defender\' END AS Position FROM CTESPN.MLS.Player WHERE PlayerTypeID <> 4" queryout {outfielder_file_path} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Outfielder.fmt'
create_outfielder = f'bcp CTESPN.MLS.Outfielder in "{outfielder_file_path}" -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Outfielder.fmt'

try:
    os.system(extract_outfielders)
    os.system(create_outfielder)
except Exception as e:
    print(e)

match_2023 = 'Data\SQL\CSV\InfoForMatchTable2023.csv'
create_match = f'bcp CTESPN.MLS.Match in {match_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\Match.fmt' 

try:
    os.system(create_match)
except Exception as e:
    print(e)

match_event_2023 = 'Data\SQL\CSV\InfoForMatchEventTable2023.csv'
create_match_event = f'bcp CTESPN.MLS.MatchEvent in {match_event_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\MatchEvent.fmt' 

try:
    os.system(create_match_event)
except Exception as e:
    print(e)

match_club_2023 = 'Data\SQL\CSV\InfoForMatchClubTable2023.csv'
create_match_club = f'bcp CTESPN.MLS.MatchClub in {match_club_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\MatchClub.fmt'

try:
    os.system(create_match_club)
except Exception as e:
    print(e)

club_player_2023 = 'Data\SQL\CSV\InfoForClubPlayerTable2023.csv'
create_club_player = f'bcp CTESPN.MLS.ClubPlayer in {club_player_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\ClubPlayer.fmt -k'

try:
    os.system(create_club_player)
except Exception as e:
    print(e)

match_club_player_2023 = 'Data\SQL\CSV\InfoForMatchClubPlayerTable2023.csv'
create_match_club_player = f'bcp CTESPN.MLS.MatchClubPlayer in {match_club_player_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\MatchClubPlayer.fmt'

try:
    os.system(create_match_club_player)
except Exception as e:
    print(e)

match_outfielder_stats_2023 = 'Data\SQL\CSV\InfoForMatchOutfielderStats2023.csv'
create_match_outfielder_stats = f'bcp CTESPN.MLS.MatchOutfielderStats in {match_outfielder_stats_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\MatchOutfielderStats.fmt'

try:
    os.system(create_match_outfielder_stats)
except Exception as e:
    print(e)

match_goalkeeper_stats_2023 = 'Data\SQL\CSV\InfoForMatchGoalkeeperStats2023.csv'
create_match_goalkeeper_stats = f'bcp CTESPN.MLS.MatchGoalkeeperStats in {match_goalkeeper_stats_2023} -S "(localdb)\MSSQLLocalDb" -T -f Data\SQL\FMT\MatchGoalkeeperStats.fmt'

try:
    os.system(create_match_goalkeeper_stats)
except Exception as e:
    print(e)

