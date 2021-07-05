class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if enough_tickets? && tall_enough?
            self.user.update(tickets: (self.user.tickets - self.attraction.tickets))
            self.user.update(nausea: (self.user.nausea + self.attraction.nausea_rating))
            self.user.update(happiness: (self.user.happiness + self.attraction.happiness_rating))
            "Thanks for riding the #{self.attraction.name}!"
        elsif !enough_tickets? && tall_enough?
            "Sorry. " + not_enough_tickets
        elsif !tall_enough? && enough_tickets?
            "Sorry. " + not_tall_enough
        else
            if !enough_tickets? && !tall_enough?
                "Sorry. " + not_enough_tickets + " " + not_tall_enough
            end
        end
    end

    
    def enough_tickets?
        self.user.tickets > self.attraction.tickets
    end

    def tall_enough?
        self.user.height > self.attraction.min_height
    end

    def not_enough_tickets
        "You do not have enough tickets to ride the #{self.attraction.name}."
    end

    def not_tall_enough
        "You are not tall enough to ride the #{self.attraction.name}."
    end
end
