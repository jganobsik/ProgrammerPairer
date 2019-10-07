class User < ApplicationRecord
    has_and_belongs_to_many :sessions
    has_many :organizers, through :sessions
end
