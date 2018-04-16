# Author: Noah Axelrod
# Date: April 3, 2018
# Purpose: Practice scraping from link:
#   https://www.sports-reference.com/cfb/years/1997-passing.html

# Import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv
import time

# Write the header of the csv file
csv_file = open('QB_stats.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Player', 'School', 'Conference', 'QBR'])


# For each year, do the following
for j in range(1997, 2018):
    # For each round, do the following
    print("Year: " + str(j))
    # Specify the URL
    page_url = 'https://www.sports-reference.com/cfb/years/' + str(j) + '-passing.html'
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
            player = columns[0].text
            if player.endswith('*'):
                player = player[:-1]
            school = columns[1].text
            conference = columns[2].text
            rating = columns[12].text
            writer.writerow([player, school, conference, rating])
        except IndexError:
            pass
        time.sleep(.25)



