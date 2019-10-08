class User < ApplicationRecord
    has_and_belongs_to_many :sessions
    has_many :organizers, through: :sessions

    def knows(user)
        friends.include?(user.name)
    end

    def add_friend(user)
        friends << user.name
    end 

    def add_past_partner(user)
        past_partners << user.name
    end
end
