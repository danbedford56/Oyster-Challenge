class Oyster_Card
    attr_reader :balance, :starting_station, :journeys

    @@MAX_BALANCE = 90
    @@MIN_FARE = 1

    def initialize()
        @balance = 0
        @starting_station = nil
        @journeys = []
    end

    def top_up(monees)
        @balance + monees > @@MAX_BALANCE ? raise("This top up exeeds max balance of £90.") : @balance += monees
        
        print_balance
    end

    def pay_fare(monees)
        @balance - monees < 0 ? raise("Cannot afford fare") : @balance -= monees
        "You have paid £#{monees}."
    end

    def touch_in(station)
        @balance >= @@MIN_FARE ? @starting_station = station : raise("You cannot cover minimum fare.")

        "You have touched in at #{station}."
    end

    def touch_out(station)
        deduct
        @starting_station = nil
        add_journey(@starting_station, station)
        "You have touched out at #{station}."
    end

    def in_journey?
        @starting_station != nil
    end

    private
        def deduct
            @balance -= @@MIN_FARE
        end

        def print_balance
            "Your balance is now £#{@balance}."
        end

        def add_journey(start, end_s)
            @journeys << {:start => start, :end => end_s}
        end

end