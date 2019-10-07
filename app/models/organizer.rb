class Organizer < ApplicationRecord
    has_and_belongs_to_many :sessions
    has_many :users, through: :sessions
end