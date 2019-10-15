class SessionsController < ApplicationController


  def create
    @session = Session.new
  end
end
