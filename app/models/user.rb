# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :sessions
  has_many :organizers, through: :sessions

  def knows?(user)
    friends.include?(user.id.to_s) || user.id == id
  end

  def add_friend(user)
    friends << user.id unless knows?(user)
  end

  def has_worked_with?(user)
    past_partners.include?(user.id.to_s) || user.id == id
  end

  def add_past_partner(user)
    past_partners << user.id.to_s unless has_worked_with?(user)
  end
end
