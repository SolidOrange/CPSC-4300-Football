# Author: John Grider
# Date: April 4, 2018
# Purpose: Scrape code to get NFL QB's QBR
# Data taken from : https://www.footballdb.com/stats/stats.html?lg=NFL&yr=2017&type=reg&mode=P&conf=&limit=all

# Import Libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv
import time

# Write header of csv file
csv_file = open('NFL_QBR.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Name', 'QBR'])

# For each year, get the QBR
for j in range(1994, 2018):
    print("Year: " + str(j))
    page_url = 'https://www.footballdb.com/stats/stats.html?lg=NFL&yr=' +\
               str(j) +\
               '&type=reg&mode=P&conf=&limit=100'
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
        player = columns[0].find('a').text
        qbr = columns[14].text
        writer.writerow([player, qbr])

    print("Finished year: " + str(j) + "...")
    time.sleep(.25)