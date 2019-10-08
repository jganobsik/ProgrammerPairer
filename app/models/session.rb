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

  def finalize_team(user1, user2)
    teams << [user1, user2]
    add_partners([user1, user2])
    delete_from_participants([user1, user2])
  end

  def add_partners(user_array)
    user_array[0].add_past_partner(user_array[1])
    user_array[1].add_past_partner(user_array[0])
  end

  def delete_from_participants(user_array)
    user_array.each do |u|
      @participants.delete(u)
    end
  end


  def assign_partners
    until @participants.length.zero?
      @team = participants.sample(2)
      finalize_team(@team[0], @team[1])
    end
  end
 
  def assign_unfamiliar_partners
    @participants.each do |p|
      @potential_partners = @participants.keep_if { |pp| !p.knows?(pp) }
      if !@potential_partners.zero? && @participants.length > 2
        finalize_team(p, @potential_partners.sample)
      end
    end
  end

  def make_unfamiliar_uneven_team(user_array)
    teams[user_array]
    @sub_teams = [[user_array[0], user_array[1]], [user_array[1], user_array[2]], [user_array[0], user_array[2]]]
    delete_from_participants(user_array)
  end

  def make_random_uneven_team
    @users = @participants.sample(3)
    teams << [@users]
    @sub_teams = [[@users[0], @users[1]], [@users[1], @users[2]], [@users[0], @users[2]]]
    @sub_teams.each do |arr|
      add_partners(arr)
    end
    delete_from_participants(@users)
  end
end
