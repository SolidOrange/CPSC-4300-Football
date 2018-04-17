class Player:
    def __init__(self, name, qbr):
        self.name = name
        self.qbr_sum = float(qbr)
        self.count = 1

    def get_name(self):
        return self.name

    def increment_qbr(self, qbr):
        self.qbr_sum += float(qbr)
        self.count += 1

    def calculate_avg(self):
        return round(self.qbr_sum / self.count, 1)