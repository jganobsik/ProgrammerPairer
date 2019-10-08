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
      @team = participants.sample(2)
      finalize_team(@team[0], @team[1])
    end
  end

  def finalize_team(user1, user2)
    teams << [user1, user2]
    user1.add_past_partner(user2)
    user2.add_past_partner(user1)
    participants.delete(user1)
    participants.delete(user2)
  end

  def assign_unfamiliar_partners
    @participants.each do |participant|
      @potential_partners = @participants.keep_if{|p| !participant.knows(p)}
    if !@potential_partners.zero? && @participants.length > 2
      finalize_team(participant, )
    else 
  end
  def make_uneven_team_of_strangers
    @users = @participants.sample(3)
    @evaluated_partners = []
    if @users[1].knows(@users[2]) 
      
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
