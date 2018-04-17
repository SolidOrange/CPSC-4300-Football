# Author: Tanner Hanson
# Date: April 4, 2018
# Purpose: Scrape poll data at
#   https://247sports.com/Season/2000-Football/CompositeRecruitRankings?InstitutionGroup=HighSchool&PositionGroup=QB


# Import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv
import time

# Write the header of the csv file
csv_file = open('QBRanking2000.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Player', 'Year', 'Rating'])

for year in range(2000, 2018):
    # Set URL
    loop_year = str(year)
    page_url = "https://247sports.com/Season/" + loop_year + "-Football/CompositeRecruitRankings?InstitutionGroup=HighSchool&PositionGroup=QB"

    # Connect to site
    req = Request(page_url, headers={'User-Agent': 'Mozilla/5.0'})
    page = urlopen(req).read()
    print("Connected to year " + loop_year + "...")

    # Create Soup
    # Parse the HTML using BeautifulSoup and store in variables
    soup = BeautifulSoup(page, 'html.parser')

    # Get Player rows
    table = soup.tbody

    rows = soup.findAll('tr')

    for row in rows:
        columns = row.find_all('td')
        player = columns[1].text
        year = loop_year
        writer.writerow([player, year, rating])

    time.sleep(1)
