# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :organizers
  after_initialize :set_arrays

  attr_accessor :participants, :teams

  def set_arrays
    @participants = []
    @teams = []
  end

  def finalize_participants
    Users.each do |user|
      @participants << user
    end
  end

  def assign_partners
    until @participants.length.zero?

    end
  end

  def finalize_team(user1, user2)
    teams << [user1, user2]
    participants.delete(user1, user2)
  end 

  def assign_unknown_partners
    @participants.each do |participant|
      @evaluated_partners = []
      while @participants.include?(participant) 
        @potential_partner = participants.sample
        # make team if user has not listed the potential partner as a friend
        if participant.evaluate_partner(@potential_partner) < 2
          finalize_team(participant, @potential_partner)
        # make team of friends if all other eligible participants have been evaluated
        elsif @evaluated_partners.length == @participants.length - 2
          finalize_team(participant, @potential_partner)
        else 
          @evaluated_partners << @potential_partner
          @potential_partner = @participants.except(@evaluated_partners).sample
        end
      end
    end
  end

  def make_uneven_team
    @users = @participants.sample(3)
    teams << [@users]
    @users.each do |user|
    @participants.delete(user)
    end
  end

end