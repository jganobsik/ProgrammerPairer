# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :sessions
  has_many :organizers, through: :sessions

  def knows?(user)
    friends.include?(user.name)
  end

  def add_friend(user)
    friends << user.name unless knows?(user)
  end

  def has_worked_with?(user)
    past_partners.include?(user)
  end

  def add_past_partner(user)
    past_partners << user.name unless has_worked_with?(user)
  end
end
