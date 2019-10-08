# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :organizers

  def finalize_participants
    Users.each do |user|
      participants << user
    end
  end

  def assign_partners

  end

  def assign_unknown_partners
    participants.each do |participant|
      while participants.include?(participant)
        @potential_partner = participants.sample
        if participant.evaluate_partner(@potential_partner) == 0
            teams << [participant, @potential_partner]
            participants.delete(participant)
            participants.delete(@potential_partner)
          else  
            @potential_partner = participants.sample
        end
      end
    end
  end

  def make_uneven_team
    @first_user = participants.sample
    @second_user = participants.sample
    @third_user = participants.sample

    if @first_user == @second_user
      @second_user = participants.sample
    elsif @second_user == @third_user
      @third_user = participants.sample
    elsif @first_user == @third_user
      @third_user = participants.sample
    end
  end
end
