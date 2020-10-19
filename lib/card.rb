require_relative 'journey_log'

class Oyster_Card
    attr_reader :balance, :starting_station, :journey_log

    @@MAX_BALANCE = 90
    @@MIN_FARE = 1
    @@PENALTY_FARE = 6

    def initialize()
        @balance = 0
        @journey_log = Journey_log.new
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
        @balance >= @@MIN_FARE ? @journey_log.start_journey(station) : raise("You cannot cover minimum fare.")
        "You have touched in at #{station}."
    end

    def touch_out(station)
        if check_penalty
            charge_penalty
        else
            deduct(@journey_log.current_journey.calculate_fare)
            @journey_log.finish_journey(station)
            "You have touched out at #{station}."
        end
    end

    def in_journey?
        if @journey_log.current_journey != nil
            !journey_log.current_journey.complete
        else
            false
        end
    end

    private
        def deduct(monees)
            @balance -= monees
        end

        def print_balance
            "Your balance is now £#{@balance}."
        end

        def check_penalty
            @journey_log.current_journey == nil
        end

        def charge_penalty
            @balance -= @PENALTY_FARE
        end

end