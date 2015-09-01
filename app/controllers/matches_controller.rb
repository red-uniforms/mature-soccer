class MatchesController < ApplicationController
  def new
    if session[:cup_id]
      @cup = Cup.find(session[:cup_id])
      @match = @cup.matches.new
    else
      redirect_to :schedule_cup_path
    end
  end
  def create
  end
end