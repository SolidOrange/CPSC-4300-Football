# Author: Will Concannon
# Date: 4/10/18
# Purpose: Scrape recruiting data at
# https://247sports.com/Season/2000-Football/CompositeRecruitRankings?Institutio
# nGroup=HighSchool&PositionGroup=QB

# Import libraries
#from urllib.request import Request, urlopen
import requests
from bs4 import BeautifulSoup
import csv
import time

# Write the header of the csv file
csv_file = open('recruiting_rankings.csv', 'w')
writer = csv.writer(csv_file)
writer.writerow(['Player', 'Rank', 'Rating'])


# For each year, do the following
#for j in range(1997, 2018):
# For each round, do the following

#print("Year: " + str(j))

# Specify the URL
# page_url = 'https://www.sports-reference.com/cfb/years/' + str(j) + '-passing.html'
# print(page_url)
page_url = 'https://247sports.com/Season/2002-Football/CompositeRecruitRankings?InstitutionGroup=HighSchool&PositionGroup=QB'

# Headers is necessary to get access to page through the library
response = requests.get(page_url, headers={'User-Agent': 'Mozilla/5.0 ('
                                                      'Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36'})
#page = urlopen(req).read()

print("Connected...")

# Parse the HTML using BeautifulSoup and store in the variables
#soup = BeautifulSoup(#page, 'html.parser')



# rows = soup.find('ul').find_all('li')[3]
# print (rows)
#
# for row in rows:
#     try:
#
#         columns = row.find_all('td')
#         player = columns[0].text
#         if player.endswith('*'):
#             player = player[:-1]
#         school = columns[1].text
#         conference = columns[2].text
#         rating = columns[12].text
#         writer.writerow([player, school, conference, rating])
#     except IndexError:
#         pass
#     time.sleep(.25)