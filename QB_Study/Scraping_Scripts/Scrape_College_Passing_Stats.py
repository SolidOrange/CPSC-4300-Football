# Author: Noah Axelrod
# Date: April 3, 2018
# Purpose: Practice scraping from link:
#   https://www.sports-reference.com/cfb/years/1997-passing.html

# Import libraries
import csv
import time
from urllib.request import Request, urlopen

from bs4 import BeautifulSoup

from Scraping_Scripts.Player_Classes.PlayerCollege import PlayerCollege

# Write the header of the csv file
csv_file = open('../Scraped_Data/Data_College_QB_Stats.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(
    ['Name', 'School', 'Conference', 'Games', 'Completions', 'Attempts',
     'Completion_Percentage', 'Yards', 'Y/A', 'TD', 'INT', 'College_QBR',
     'Rush_Attempts', 'Rushing_Yds', 'Rushing_Avg', 'Rushing_Td'])

# FIX TO DUPLICATE NAMES
# Use an set to store Player Objects and a set of tuples to check unique
# names and colleges. Names and colleges included to make sure no duplicate
# names
unique_players = set()
player_objects = set()

# For each year, do the following
for j in range(1986, 2018):
    # For each round, do the following
    print("Year: " + str(j))
    # Specify the URL
    page_url = 'https://www.sports-reference.com/cfb/years/' + str(
        j) + '-passing.html'
    print(page_url)

    # Headers is necessary to get access to page through the library
    req = Request(page_url, headers={'User-Agent': 'Mozilla/5.0'})
    page = urlopen(req).read()

    print("Connected...")

    # Parse the HTML using BeautifulSoup and store in the variables
    soup = BeautifulSoup(page, 'html.parser')

    # Get player rows
    table = soup.tbody

    rows = table.find_all('tr')

    for row in rows:
        try:
            columns = row.find_all('td')
            player_name = columns[0].text.replace("*", "")
            school = columns[1].text.strip()
            conference = columns[2].text.strip()
            games = float(columns[3].text)
            completions = float(columns[4].text)
            attempts = float(columns[5].text)
            yards = float(columns[7].text)
            tds = float(columns[10].text)
            interceptions = float(columns[11].text)
            rushingAtt = float(columns[13].text)
            rushingYds = float(columns[14].text)
            rushingTds = float(columns[16].text)

            id_tuple = (player_name, school)
            # If it is not a new player
            if id_tuple in unique_players:
                # Increment all required variables just scraped

                # Get the corresponding player object
                for processed_player in player_objects:
                    if (player_name == processed_player.name and school ==
                                processed_player.school):
                        processed_player.increment_stats(games, completions,
                                                         attempts, yards, tds,
                                                         interceptions,
                                                         rushingAtt, rushingYds,
                                                         rushingTds)
            else:
                # Initialize the player object, add name to set, and add object
                # to list
                unique_players.add(id_tuple)
                new_player = PlayerCollege(player_name, school, conference,
                                           games, completions, attempts, yards,
                                           tds, interceptions, rushingAtt,
                                           rushingYds, rushingTds)
                player_objects.add(new_player)

        except IndexError:
            pass

        time.sleep(.25)

for player in player_objects:
    print(player.name + " " + player.school)
    writer.writerow(
        [player.name, player.school, player.conference, player.games,
         player.cmp, player.att, player.pct, player.yds, player.yatt,
         player.tds, player.interceptions, player.qbr, player.ratt, player.ryds,
         player.ravg, player.rtd])
