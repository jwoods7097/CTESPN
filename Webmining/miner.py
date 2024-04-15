import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.support.ui import WebDriverWait as wait
from selenium.common.exceptions import NoSuchElementException
from datetime import date
import pandas as pd

# Matches
columns = {'HomeClub': [], 'AwayClub': [], 'Location': [], 'Date': [], 'Attendance': [], 'HomeFormation': [], 'AwayFormation': [], 'HomeScore': [], 'AwayScore': []}
matches_df = pd.DataFrame(data=columns)

#d = str(date.today()).replace('-', '')
d = '20240406'

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
driver.implicitly_wait(5)

driver.get(f'https://www.espn.com/soccer/scoreboard/_/date/{d}/league/usa.1')
stats_button = driver.find_element('xpath', '/html/body/div[1]/div/div/div/div/main/div[3]/div/div/div[1]/div/div/section/div/section[1]/div[2]/a[2]')
stats_button.click()

homeClub = driver.find_elements("xpath",'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[1]/div/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/div/a/h2')
print(homeClub[0].get_attribute('textContent'))

"""
columns = {
    'HomeClub': driver.find_elements("xpath",'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[1]/div/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/div/a/h2')[0].get_attribute('textContent'),
    'AwayClub': driver.find_elements("xpath",'/html/body/div[1]/div/div/div/div/main/div[2]/div/div[1]/div/div[2]/div[3]/div[2]/div[1]/div[1]/div[1]/div/a/h2')[0].get_attribute('textContent'), 
    'Location': , 
    'Date': d[:4] + '-' + d[4:6] + '-' + d[6:], 
    'Attendance': , 
    'HomeFormation': '', 
    'AwayFormation': '', 
    'HomeScore': , 
    'AwayScore': 
}
"""