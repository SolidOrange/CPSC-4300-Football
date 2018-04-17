# Author: John Grider
# Date: April 4, 2018
# Purpose: Scrape code to get NFL QB's QBR
# Data taken from :
#   https://www.footballdb.com/stats/stats.html?lg=NFL&yr=2017&type=reg&mode=P&conf=&limit=all

# Import Libraries
import csv
import time
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
# Include custom Player class
from Scraping_Scripts.Player_Classes.PlayerPro import PlayerPro

# Write header of csv file
csv_file = open('../Scraped_Data/Data_NFL_QBR.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Name', 'QBR'])

# FIX TO DUPLICATE NAMES
# Use an array to store Player Objects and a set to check unique names
unique_players = set()
player_objects = []

# For each year, get the QBR
for j in range(1994, 2018):
    print("Year: " + str(j))
    page_url = 'https://www.footballdb.com/stats/stats.html?lg=NFL&yr=' + str(
        j) + '&type=reg&mode=P&conf=&limit=100'
    print(page_url)

    # Header is necessary to get access to page through library
    req = Request(page_url, headers={'User-Agent': 'Mozilla/5.0'})
    page = urlopen(req).read()

    print("Connected...")

    # Parse the HTML using BeautifulSoup and store in variables
    soup = BeautifulSoup(page, 'html.parser')

    # Get Player rows
    table = soup.tbody
    rows = table.find_all('tr')

    for row in rows:
        columns = row.find_all('td')
        player_name = columns[0].find('a').text
        completions = round(float(columns[3].text),0)
        pass_attempts = round(float(columns[2].text.replace(",", "")),0)
        yards = round(float(columns[5].text.replace(",", "")),0)
        tds = round(float(columns[7].text),0)
        interceptions = round(float(columns[9].text),0)

        # If it is not a new player
        if player_name in unique_players:
            # Increment their qbr and count variables

            # Get the corresponding player object
            for processed_player in player_objects:
                if player_name == processed_player.name:
                    processed_player.increment_stats(completions, pass_attempts,
                                                     yards, tds, interceptions)
        else:
            # Initialize the player object, add name to set, and add object
            # to list
            unique_players.add(player_name)
            new_player = PlayerPro(player_name, completions,
                                pass_attempts,
                                yards,
                                tds, interceptions)
            player_objects.append(new_player)

    time.sleep(.25)

# Write to csv
for player in player_objects:
    writer.writerow([player.name, player.qbr])
