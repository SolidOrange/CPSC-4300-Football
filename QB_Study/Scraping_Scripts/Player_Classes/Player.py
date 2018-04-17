class Player:

    # Init and functions for Scrape_NFL_QBR
    def __init__(self, name, cmp, att, yds, tds, interceptions):
        self.name = name
        self.cmp = cmp
        self.att = att
        self.pct = self.cmp / self.att
        self.yds = yds
        self.yatt = self.yds / self.att
        self.tds = tds
        self.interceptions = interceptions
