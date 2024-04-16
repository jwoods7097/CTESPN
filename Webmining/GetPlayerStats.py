#!/usr/bin/env python
# coding: utf-8

# In[1]:


import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait as wait
from selenium.common.exceptions import NoSuchElementException
from datetime import date
import pandas as pd


# In[2]:


driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))


# In[10]:


player_stats_table = []
player_id = 117713
stat_year = 2012

driver.get(f'https://www.espn.com/soccer/player/matches/_/id/{player_id}/type/usa.1/year/{stat_year}')


# In[11]:


#CS	SV	GA	G	A	FC	FA	YC	RC
position_element = driver.find_element("xpath", "/html/body/div[1]/div/div/div/div/main/div[2]/div[1]/div/div/div[1]/div[1]/div[2]/div/ul/li[3]").text
check_element = driver.find_element("xpath", "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/section/div/div/div").text


# In[ ]:


if check_element != "No available information.":
    if position_element == 'G':
        goalie_season_stats = [stat_year]

        goalie_match_ids = []
        single_match_ids = (driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[3]/a"))
        for e in single_match_ids:
            href = e.get_attribute("href")
            # Extract gameId from href attribute
            game_id = href.split("/")[-2]
            # Check if gameId is not already in the list before adding it
            if game_id not in goalie_match_ids:
                # Add gameId to the list
                #print(game_id)
                goalie_match_ids.append(game_id)
        goalie_season_stats.append(goalie_match_ids)

        goalie_cs = []
        goalie_cs_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[4]")
        for e in goalie_cs_elements:
            goalie_cs.append(e.text)
        goalie_season_stats.append(goalie_cs)

        goalie_sv = []
        goalie_sv_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[5]")
        for e in goalie_sv_elements:
            goalie_sv.append(e.text)
        goalie_season_stats.append(goalie_sv)

        goalie_ga = []
        goalie_ga_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[6]")
        for e in goalie_ga_elements:
            goalie_ga.append(e.text)
        goalie_season_stats.append(goalie_ga)

        goalie_g = []
        goalie_g_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[7]")
        for e in goalie_g_elements:
            goalie_g.append(e.text)
        goalie_season_stats.append(goalie_g)

        goalie_a = []
        goalie_a_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[8]")
        for e in goalie_a_elements:
            goalie_a.append(e.text)
        goalie_season_stats.append(goalie_a)

        goalie_fc = []
        goalie_fc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[9]")
        for e in goalie_fc_elements:
            goalie_fc.append(e.text)
        goalie_season_stats.append(goalie_fc)

        goalie_fa = []
        goalie_fa_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[10]")
        for e in goalie_fa_elements:
            goalie_fa.append(e.text)
        goalie_season_stats.append(goalie_fa)

        goalie_yc = []
        goalie_yc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[11]")
        for e in goalie_yc_elements:
            goalie_yc.append(e.text)
        goalie_season_stats.append(goalie_yc)

        goalie_rc = []
        goalie_rc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[12]")
        for e in goalie_rc_elements:
            goalie_rc.append(e.text)
        goalie_season_stats.append(goalie_rc)


# In[12]:


if position_element != 'G':
    player_season_stats = [stat_year]

    player_match_ids = []
    single_match_ids = (driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[3]/a"))
    for e in single_match_ids:
        href = e.get_attribute("href")
        # Extract gameId from href attribute
        game_id = href.split("/")[-2]
        # Check if gameId is not already in the list before adding it
        if game_id not in player_match_ids:
            # Add gameId to the list
            player_match_ids.append(game_id)
    player_season_stats.append(player_match_ids)

    player_g = []
    player_g_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[4]")
    for e in player_g_elements:
        player_g.append(e.text)
    player_season_stats.append(player_g)

    player_a = []
    player_a_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[5]")
    for e in player_a_elements:
        player_a.append(e.text)
    player_season_stats.append(player_a)

    player_sh = []
    player_sh_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[6]")
    for e in player_sh_elements:
        player_sh.append(e.text)
    player_season_stats.append(player_sh)

    player_st = []
    player_st_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[7]")
    for e in player_st_elements:
        player_st.append(e.text)
    player_season_stats.append(player_st)

    player_fc = []
    player_fc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[8]")
    for e in player_fc_elements:
        player_fc.append(e.text)
    player_season_stats.append(player_fc)

    player_fa = []
    player_fa_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[9]")
    for e in player_fa_elements:
        player_fa.append(e.text)
    player_season_stats.append(player_fa)

    player_of = []
    player_of_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[10]")
    for e in player_of_elements:
        player_of.append(e.text)
    player_season_stats.append(player_of)

    player_yc = []
    player_yc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[11]")
    for e in player_yc_elements:
        player_yc.append(e.text)
    player_season_stats.append(player_yc)

    player_rc = []
    player_rc_elements = driver.find_elements(By.XPATH, "/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/div[1]/div/div[*]/div[2]/div/div/div/div/div[2]/table/tbody/tr[*]/td[12]")
    for e in player_rc_elements:
        player_rc.append(e.text)
    player_season_stats.append(player_rc)

print(player_g)
print()
print(player_of)



# In[ ]:




