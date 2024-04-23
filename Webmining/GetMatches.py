from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions

from datetime import date, timedelta
import pandas as pd

matches_rows = []
match_events_rows = []
match_club_players_rows = []

def get_element(id, use_xpath):
    return WebDriverWait(driver, 1).until(
        expected_conditions.presence_of_element_located((By.XPATH if use_xpath else By.CLASS_NAME, id))
    )

def get_element_text(id, use_xpath):
    return get_element(id, use_xpath).get_attribute('textContent')

def get_element_link(id, use_xpath):
    return get_element(id, use_xpath).get_attribute('href')

def save():
    matches_df = pd.DataFrame(matches_rows)
    matches_df.to_excel('matches.xlsx')

    match_club_players_df = pd.DataFrame(match_club_players_rows)
    match_club_players_df.to_excel('match_club_players.xlsx')

    match_events_df = pd.DataFrame(match_events_rows)
    match_events_df.to_excel('match_events.xlsx')

d = date(2024, 4, 14)
first_date = date(2001, 4, 7)

# Start driver
driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
driver.implicitly_wait(5)

try:
    # Loop through all the dates
    while d >= first_date:

        # Click on page for each match
        date_string = str(d).replace('-', '')
        driver.get(f'https://www.espn.com/soccer/scoreboard/_/date/{date_string}/league/usa.1')
        i = 1
        stats_button = driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[3]/div/div[1]/div[1]/div/div/section/div/section[{i}]/div[2]/a[2]')
        while len(stats_button) > 0:
            stats_button[0].click()

            # Define columns
            matches_columns = {
                'MatchID': driver.current_url.split('/')[-1],
                'HomeClub': '',
                'AwayClub': '', 
                'Location': get_element_text("Location__Text", False), 
                'Date': str(d),
                'Attendance': get_element_text("Attendance__Numbers", False).split(' ')[1], 
                'HomeFormation': '', 
                'AwayFormation': '', 
                'HomeScore': get_element_text("/html/body/div[1]/div/div/div/div/main/div[2]/div/div[1]/div/div[2]/div[1]/div[2]/div[2]/div", True)[:1], 
                'AwayScore': get_element_text("/html/body/div[1]/div/div/div/div/main/div[2]/div/div[1]/div/div[2]/div[3]/div[2]/div[2]/div", True)[:1]
            }

            # For some god awful reason the layout of ESPN changes if the game was a 0-0 draw
            i_hate_espn = 6
            try:
                # Try getting an element that would be affected by this
                get_element(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/section/div/div[1]/a[1]/span", True)
            except:
                i_hate_espn = 5

            # Get clubs
            matches_columns['HomeClub'] = get_element_text(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/section/div/div[1]/a[1]/span", True)
            matches_columns['AwayClub'] = get_element_text(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/section/div/div[1]/a[2]/span", True)

            # Get formations
            driver.get(f"https://www.espn.com/soccer/lineups/_/gameId/{matches_columns['MatchID']}")
            matches_columns['HomeFormation'] = get_element_text(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[1]/span/span/span", True)
            matches_columns['AwayFormation'] = get_element_text(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[1]/span/span/span", True)
            
            matches_rows.append(matches_columns)

            def collect_match_club_player(player_type, k, played):
                match_club_players_columns = {
                    'PlayerID': '',
                    'PlayerType': player_type,
                    'MatchID': matches_columns['MatchID'],
                    'Club': matches_columns[f'{player_type}Club'],
                    'SubstitutedForPlayer': '',
                    'SubstitutionTime': '',
                    'Played': str(played)
                }

                if played:
                    if player_type == 'Home':
                        # Check if player was subbed or not
                        try:
                            match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[1]/div[1]/a", True).split('/')[-2]
                            match_club_players_columns['SubstitutedForPlayer'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[2]/div[1]/a", True).split('/')[-2]
                            match_club_players_columns['SubstitutionTime'] = '+'.join([t + "'" for t in get_element(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[2]/div[1]/div[1]", True).find_element(By.CLASS_NAME, "SoccerLineUpPlayer__Header__SubstitutionIcon").get_attribute('aria-label').split(' ')[-1].split('+')])
                        except:
                            match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div/div[1]/a", True).split('/')[-2]
                    elif player_type == 'Away':
                        # Check if player was subbed or not
                        try:
                            match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[1]/div[1]/a", True).split('/')[-2]
                            match_club_players_columns['SubstitutedForPlayer'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[2]/div[1]/a", True).split('/')[-2]
                            match_club_players_columns['SubstitutionTime'] = '+'.join([t + "'" for t in get_element(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div[2]/div[1]/div[1]", True).find_element(By.CLASS_NAME, "SoccerLineUpPlayer__Header__SubstitutionIcon").get_attribute('aria-label').split(' ')[-1].split('+')])
                        except:
                            match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[3]/div/div/div[2]/table/tbody/tr[{k}]/td/div/div[1]/a", True).split('/')[-2]
                    else:
                        raise ValueError('PlayerType can only be Home or Away')
                else:
                    if player_type == 'Home':
                        match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[1]/div/div[4]/div/div/div[2]/table/tbody/tr[{k}]/td/div/div[1]/a", True).split('/')[-2]
                    elif player_type == 'Away':
                        match_club_players_columns['PlayerID'] = get_element_link(f"/html/body/div[1]/div/div/div/div/main/div[2]/div/div[{i_hate_espn}]/div/div[1]/div[1]/section[2]/div/div[4]/div/div/div[2]/table/tbody/tr[{k}]/td/div/div[1]/a", True).split('/')[-2]
                    else:
                        raise ValueError('PlayerType can only be Home or Away')

                return match_club_players_columns
            
            # Get MatchClubPlayers who were on the field
            for k in range(1, 12):
                match_club_players_rows.append(collect_match_club_player('Home', k, True))
                match_club_players_rows.append(collect_match_club_player('Away', k, True))
            
            # Get Home substitutes
            k = 1
            while True:
                try:
                    match_club_players_rows.append(collect_match_club_player('Home', k, False))
                    k += 1
                except:
                    break

            # Get Away substitues
            k = 1
            while True:
                try:
                    match_club_players_rows.append(collect_match_club_player('Away', k, False))
                    k += 1
                except:
                    break

            # MatchEvents
            driver.get(f"https://www.espn.com/soccer/commentary/_/gameId/{matches_columns['MatchID']}")

            # Loop through rows of commentary table
            j = 1
            timestamp =  driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[6]/div/div[1]/section[2]/div/div[2]/div/div/div[2]/table/tbody/tr[{j}]/td/div/div[1]/span')
            commentary =  driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[6]/div/div[1]/section[2]/div/div[2]/div/div/div[2]/table/tbody/tr[{j}]/td/div/div[3]/span')
            while len(timestamp) > 0 and len(commentary) > 0:
                match_events_columns = {
                    'MatchID': matches_columns['MatchID'],
                    'Time': timestamp[0].get_attribute('textContent'),
                    'Commentary': commentary[0].get_attribute('textContent')
                }
                match_events_rows.append(match_events_columns)
                j += 1
                timestamp =  driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[6]/div/div[1]/section[2]/div/div[2]/div/div/div[2]/table/tbody/tr[{j}]/td/div/div[1]/span')
                commentary =  driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[6]/div/div[1]/section[2]/div/div[2]/div/div/div[2]/table/tbody/tr[{j}]/td/div/div[3]/span')

            # Go back to scoreboard page for next iteration
            driver.get(f'https://www.espn.com/soccer/scoreboard/_/date/{date_string}/league/usa.1')
            i += 1
            stats_button = driver.find_elements('xpath', f'/html/body/div[1]/div/div/div/div/main/div[3]/div/div[1]/div[1]/div/div/section/div/section[{i}]/div[2]/a[2]')

        # Decrement date
        d -= timedelta(days=1)

        # Periodically save the matches
        if len(matches_rows) % 50 == 0:
            save()

finally:
    # Save if script ever crashes
    save()
