#!/usr/bin/env python
# coding: utf-8

# In[1]:


import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.support.ui import WebDriverWait as wait
from selenium.common.exceptions import NoSuchElementException
from datetime import date
import pandas as pd


# In[2]:


driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

PlayerName = []
PlayerID = []
PlayerPosition = []


# In[3]:


club_ids = [
18418,
20906,
9720,
21300,
182,
184,
183,
193,
18267,
185,
6077,
20232,
187,
18966,
17362,
18986,
189,
17606,
190,
12011,
10739,
9723,
4771,
191,
9726,
186,
21812,
7318,
9727]

#for club in club_ids:
driver.implicitly_wait(5)
driver.get(f'https://www.espn.com/soccer/team/squad/_/id/186/league/USA.1/season/2024')

outfield_names_elements = driver.find_elements('xpath', '/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/section/div/section/div[2]/div[2]/div[2]/div/div[2]/table/tbody/tr[*]/td[1]/div/a')
outfield_position_elements = driver.find_elements('xpath', '/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/section/div/section/div[2]/div[2]/div[2]/table/tbody/tr[*]/td[2]')
print(outfield_position_elements)
goalie_names_elements = driver.find_elements('xpath', '/html/body/div[1]/div/div/div/div/main/div[2]/div[5]/div/div/section/div/section/div[2]/div[1]/div[2]/div/div[2]/table/tbody/tr[*]/td[1]/div/a')

for e in outfield_names_elements:
    href = e.get_attribute("href")
    # Extract PlayerID from href attribute
    player_id = href.split("/")[-2]
    if player_id not in PlayerID:
        # Add PlayerID to the list
        #print(player_id)
        PlayerID.append(player_id)

for e in goalie_names_elements:
    href = e.get_attribute("href")
    # Extract PlayerID from href attribute
    player_id = href.split("/")[-2]
    if player_id not in PlayerID:
        # Add PlayerID to the list
        #print(player_id)
        PlayerID.append(player_id)

for p in outfield_names_elements:
    name_text = p.get_attribute("text")
    #print(name_text)
    PlayerName.append(name_text)
    
for p in outfield_position_elements:
    position_text = p.get_attribute("text")
    print(position_text)
    PlayerPosition.append(position_text)
    
for p in goalie_names_elements:
    name_text = p.get_attribute("text")
    PlayerName.append(name_text)
    PlayerPosition.append("G")


# In[ ]:


players = pd.DataFrame(data=columns)

