require_relative 'journey'

class Oyster_Card
    attr_reader :balance, :starting_station, :journeys

    @@MAX_BALANCE = 90
    @@MIN_FARE = 1

    def initialize()
        @balance = 0
        @journeys = []
        @current_journey = nil
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
        @balance >= @@MIN_FARE ? @current_journey = Journey.new : raise("You cannot cover minimum fare.")
        @current_journey.start_journey(station)
        "You have touched in at #{station}."
    end

    def touch_out(station)
        deduct
        @current_journey.finish_journey(station)
        add_journey(@current_journey)
        @current_journey = nil
        "You have touched out at #{station}."
    end

    def in_journey?
        if @current_journey != nil
            !@current_journey.complete
        else
            false
        end
    end

    private
        def deduct
            @balance -= @@MIN_FARE
        end

        def print_balance
            "Your balance is now £#{@balance}."
        end

        def add_journey(journey)
            @journeys << journey
        end

end