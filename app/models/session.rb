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

  def add_participant(user)
      @participants << user
      users << user
  end

  def assign_partners
    until @participants.length.zero?
      @team = participants.sample(2)
      finalize_team(@team[0], @team[1])
    end
  end

  def finalize_team(user1, user2)
    teams << [user1, user2]
    participants.delete(user1)
    participants.delete(user2)
  end

  def add_partners(user_array)
    user_array.each do |u|
      u.add_past_partner()
    end
  end

  def delete_from_participants(user_array)
  user_array.each do |u|
    @participants.delete(u)
  end
  end
  def assign_unfamiliar_partners
    @participants.each do |participant|
      @potential_partners = @participants.keep_if{|p| !participant.knows(p)}
    if !@potential_partners.zero? && @participants.length > 2
      finalize_team(participant,  @potential_partners.sample)
    else 

    end
  end
  end
  def make_uneven_team_of_strangers
    @users = @participants.sample(3)
    @evaluated_partners = []
    if @users[1].knows?(@users[2]) 
      
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
