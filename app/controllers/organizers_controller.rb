# frozen_string_literal: true

class OrganizersController < ApplicationController
  def new
    @organizer = organizer.new
  end

  def create
    @organizer = organizer.new(organizer_params)
    if @organizer.save
      session[:organizer_id] = @organizer.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def organizer_params
    params.require(:organizer).permit(:username, :password)
  end
end
