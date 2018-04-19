# Author: Will Concannon
# Date: April 17, 2018
# Purpose: Scrape code to get NFL QB's QBR
#
# Data borrowed from : http://www.nfl.com/stats/categorystats?tabSeq=1&season
# =1987&seasonType=REG&d-447263-p=1&statisticPositionCategory=QUARTERBACK&
# qualified=true

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
for j in range(1987, 2018):

    print("Year: " + str(j))
    #For all the possilbe pages
    try:
        for i in range(1, 4):
            page_url = 'http://www.nfl.com/stats/categorystats?tabSeq=1&season=' + \
                       str(j) +'&seasonType=REG&d-447263-p=' + str(i) + \
                       '&statisticPositionCategory=QUARTERBACK&qualified=true'
            print(page_url)

            # Header is necessary to get access to page through library
            req = Request(page_url, headers={'User-Agent': 'Mozilla/5.0'})
            page = urlopen(req).read()

            print("Connected...")

            # Parse the HTML using BeautifulSoup and store in variables
            soup = BeautifulSoup(page, 'html.parser')

            # Get Player rows
            table = soup.find(id='result')
            tbody = table.find('tbody')
            rows = tbody.find_all('tr')

            for row in rows:
                columns = row.find_all('td')
                player_name = columns[1].find('a').text.strip()
                cmp = int(columns[4].text.strip().replace(",",""))
                att = int(columns[5].text.strip().replace(",",""))
                yds = int(columns[8].text.strip().replace(",",""))
                tds = int(columns[11].text.strip().replace(",",""))
                interceptions = int(columns[12].text.strip().replace(",",""))

                # If it is not a new player
                if player_name in unique_players:
                    # Increment their qbr and count variables

                    # Get the corresponding player object
                    for processed_player in player_objects:
                        if player_name == processed_player.name:
                            processed_player.increment_stats(cmp, att,yds, tds,
                                                             interceptions)
                else:
                    # Initialize the player object, add name to set, and add object
                    # to list
                    unique_players.add(player_name)
                    new_player = PlayerPro(player_name, cmp, att, yds, tds, interceptions)
                    player_objects.append(new_player)
    except (AttributeError):
        continue

    time.sleep(.25)

# Write to csv
for player in player_objects:
    writer.writerow([player.name, player.qbr])
