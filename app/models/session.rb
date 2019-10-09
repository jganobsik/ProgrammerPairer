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

  def find_non_friend(user)
    @potential_partners = @participants.clone.keep_if { |pp| !user.knows?(pp) }
    if potential_partners.empty?
      false
    else
      potential_partners.sample
    end
  end

  def find_new_partner(user)
    @potential_partners = @participants.clone.keep_if { |pp| !user.has_worked_with?(pp) }
    if potential_partners.empty?
      false
    else
      potential_partners.sample
    end
  end

  def find_stranger(user)
    @potential_partners = @participants.clone.keep_if { |pp| !user.has_worked_with?(pp) && !user.knows?(pp) }
    if potential_partners.empty?
      false
    else
      potential_partners.sample
    end
  end

  def assign_partners
    until @participants.length.zero?
      @team = participants.sample(2)
      finalize_team(@team[0], @team[1])
    end
  end

  def assign_partners_no_friends
    until @participants.length == 2
      @participants.each do |p|
        @partner = find_non_friend(p)
        @partner == false ? finalize_team(p, @participants.sample) : finalize_team(p, @partner)
      end
    end
    finalize_team(@participants[0], @participants[1])
  end

  def assign_partners_avoid_past
    until @participants.length == 2
      @participants.each do |p|
        @partner = find_new_partner(p)
        @partner == false ? finalize_team(p, @participants.sample) : finalize_team(p, @partner)
      end
    end
    finalize_team(@participants[0], @participants[1])
  end

  def assign_partners_no_friends_avoid_past
    until @participants.length == 2
      @participants.each do |p|
        @partner = find_stranger(p)
        if @partner == false && find_non_friend(p) == false
          finalize_team(p, @participants.sample)
        else 
          finalize_team(p, find_non_friend(p))
        end
      end
    end
    finalize_team(@participants[0], @participants[1])
  end

  def make_uneven_team(user_array)
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
