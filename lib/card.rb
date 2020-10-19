class Oyster_Card
    attr_reader :balance

    def initialize()
        @balance = 0
    end

    def top_up(monees)
        @balance += monees
        "Your balance is now £#{@balance}."
    end

end