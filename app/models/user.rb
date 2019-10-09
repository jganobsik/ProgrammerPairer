# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :sessions
  has_many :organizers, through: :sessions

  def knows?(user)
    friends.include?(user.id)
  end

  def add_friend(user)
    if knows?(user) || user.id == id
      nil
    else
      friends << user.id
    end
  end

  def has_worked_with?(user)
    past_partners.include?(user.id)
  end

  def add_past_partner(user)
    if has_worked_with?(user) || user.id == self.id
      nil
    else
      past_partners << user.id
    end
  end
end
