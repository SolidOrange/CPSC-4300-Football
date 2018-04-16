# Author: Will Concannon
# Date: February 7, 2018
# Purpose: Practice scraping from link:
#   http://nflcombineresults.com/nflcombinedata.php?year=all&pos=QB

# Must be in Python 2

# Import libraries
import urllib2
from bs4 import BeautifulSoup
import csv

# Specify the URLs
page_url = 'http://nflcombineresults.com/nflcombinedata_expanded.php?year=all&pos=QB&college='

# Query the website and return the the HTML to the variables
page = urllib2.urlopen(page_url)

# Parse the HTML using BeautifulSoup and store in the variables
soup = BeautifulSoup(page,'html.parser')

# Get header columns
header_categories = soup.thead.find_all('td')
categories = []

# Scrape columns and add them to categories array
for i in range(len(header_categories)):
    if header_categories[i].text not in categories:
        categories.append(str(header_categories[i].text))

# Write header to database
# Open a csv file with append, so old data will not be replaced
csv_file = open('combine.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(categories)

# Get player data

player_metrics = []
database_lines = []
player_row = soup.tbody.find_all('td')

# Used for knowing when its a new row
player_id = 0

for row in player_row:
    if player_id % 16 == 0 and player_id != 0:
        database_lines.append(player_metrics)
        player_metrics = []

    player_metrics.append(str(row.text))

    player_id += 1

for line in database_lines:
    print line
    writer.writerow(line)

# Close csv file
csv_file.close()






