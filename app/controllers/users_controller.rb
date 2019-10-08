# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = user.new
  end

  def create
    @user = user.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
