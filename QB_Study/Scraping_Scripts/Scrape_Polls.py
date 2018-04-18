# Author: Will Concannon
# Date: April 2, 2018
# Purpose: Scrape poll data at
#   https://www.sports-reference.com/cfb/years/2017-polls.html

# Must be in Python 3

# Import libraries
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import csv
import time

# Write the header of the csv file
csv_file = open('../Scraped_Data/Data_Polls.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Year', 'Rank', 'School'])


for year in range(1997, 2018):
    # Set URL
    loop_year = str(year)
    page_url = "https://www.sports-reference.com/cfb/years/" + loop_year \
               + "-polls.html"

    # Connect to site
    req = Request(page_url)
    page = urlopen(req).read()
    print("Connected to year " + loop_year + "...")

    # Create Soup
    soup = BeautifulSoup(page,'html.parser')

    # Go through table and get all rows where date is Final
    table = soup.tbody
    rows = table.find_all('tr')
    for row in rows:
        try:
            columns = row.find('td').get_text()
            if(columns == "Final"):
                attributes = row.find_all('td')
                rank = attributes[1].get_text()
                team = attributes[2].get_text()
                # Clean off parentheses
                parentheses_index = team.find('(')

                if(parentheses_index > 0):
                    if(team[parentheses_index+1].isalpha()):
                        parentheses_index = team.find(")")
                        team = team[:parentheses_index+1]
                    else:
                        team = team[:parentheses_index]

                # Write to CSV
                writer.writerow([year, rank, team])
        except:
            break

    # Don't abuse server and get kicked off
    time.sleep(.25)







