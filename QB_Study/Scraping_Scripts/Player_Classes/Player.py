class Player:

    # Init and functions for Scrape_NFL_QBR
    def __init__(self, name, cmp, att, yds, tds, interceptions):
        self.name = name
        self.cmp = cmp
        self.att = att
        self.yds = yds
        self.tds = tds
        self.interceptions = interceptions
        try:
            self.pct = self.cmp / self.att
            self.yatt = self.yds / self.att
        except ZeroDivisionError:
            self.pct = 0
            self.yatt = 0

