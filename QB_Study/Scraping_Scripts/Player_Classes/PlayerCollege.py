from Scraping_Scripts.Player_Classes.Player import Player


class PlayerCollege(Player):
    def __init__(self, name, school, conference, games, cmp, att, yds, tds,
                 interceptions, ratt, ryds, rtd):
        super().__init__(name, cmp, att, yds, tds, interceptions)
        self.school = school
        self.conference = conference
        self.games = games
        self.ratt = ratt
        self.ryds = ryds
        self.ravg = self.ryds / self.ratt
        self.rtd = rtd
        self.qbr = self.calculate_qbr()


    def increment_stats(self, games, cmp, att, yds, td, interceptions, ratt,
                        ryds, rtd):
        self.games += games
        self.cmp += cmp
        self.att += att
        self.pct = self.cmp / self.att
        self.yds += yds
        self.yatt = self.yds / self.att
        self.tds += td
        self.interceptions += interceptions
        self.ratt += ratt
        self.ryds += ryds
        self.ravg = self.ryds / self.ratt
        self.rtd += rtd
        self.qbr = self.calculate_qbr()

    # Use the official NCAA QBR algorithm to calculate qbr in 4 steps
    # Algorithm can be seen here:
    #   https://en.wikipedia.org/wiki/Passer_rating#NFL_and_CFL_formula
    def calculate_qbr(self):
        total = ((8.4 * self.yds) + (330 * self.tds) + (100 * self.cmp) - (
            200 * self.interceptions)) / self.att
        if total < 0:
            total = 0
        return total
