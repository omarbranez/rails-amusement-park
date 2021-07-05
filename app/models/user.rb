class User < ActiveRecord::Base
    has_many :rides
    has_many :attractions, through: :rides
    has_secure_password
    after_initialize :set_default

    def mood
        unless admin
            nausea > happiness ? "sad" : "happy"
        end
    end

    def set_default
        self.admin = false if self.admin.nil?
    end
end
