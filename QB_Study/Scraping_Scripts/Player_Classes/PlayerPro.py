from Scraping_Scripts.Player_Classes.Player import Player


class PlayerPro(Player):
    # Init and functions for Scrape_NFL_QBR
    # def __init__(self, name, qbr):
    def __init__(self, name, cmp, att, yds, tds, interceptions):
        super().__init__(name, cmp, att, yds, tds, interceptions)
        self.qbr = self.calculate_qbr()


    def increment_stats(self, cmp, att, yds, tds, interceptions):
        self.cmp += cmp
        self.att += att
        self.pct = self.cmp / self.att
        self.yds += yds
        self.yatt = self.yds / self.att
        self.tds += tds
        self.interceptions += interceptions
        self.qbr = self.calculate_qbr()

    # Use the official NFL QBR algorithm to calculate qbr in 4 steps
    # Algorithm can be seen here:
    #   https://en.wikipedia.org/wiki/Passer_rating#NCAA_formula
    def calculate_qbr(self):
        completion_percentage = (self.pct - 30) * .05
        yards_per_attempt = (self.yatt - 3) * .25
        td_percentage = self.tds / self.att * .2
        int_percentage = 2.375 - self.interceptions / self.att * .25

        total = (completion_percentage + yards_per_attempt + td_percentage +
                 int_percentage) / 6 * 100

        return total
