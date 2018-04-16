# Author: Will Concannon
# Date: February 7, 2018
# Purpose: Practice scraping from site:
#   https://www.footballdb.com/draft/index.html

# Must be in Python 3

# Import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv
import time

# Write the header of the csv file
csv_file = open('draft_order.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Pick', 'Player', 'Position', 'College'])


# For each year, do the following
for j in range(1994, 2018):
    # For each round, do the following
    print("Year: " + str(j))

    for i in range (1, 8):
        # Specify the URL
        page_url = 'https://www.footballdb.com/draft/draft.html?lg=NFL&yr=' +\
                   str(j) + \
                   '&rnd=' + str(i)

        print(page_url)

        # Headers is necessary to get access to page through the library
        req = Request(page_url, headers={'User-Agent': 'Mozilla/5.0'})
        page = urlopen(req).read()

        print("Connected...")

        #Parse the HTML using BeautifulSoup and store in the variables
        soup = BeautifulSoup(page,'html.parser')

        # Get player rows
        table = soup.tbody

        rows = table.find_all('tr')

        for row in rows:
            columns = row.find_all('td')
            pick = columns[1].text
            player = columns[3].text
            position = columns[4].text
            college = columns[5].text
            if(position == "QB"):
                writer.writerow([pick, player, position, college])

        print("Finished Round " + str(i) + "...")
        time.sleep(1)








