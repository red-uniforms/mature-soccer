class MatchesController < ApplicationController
  before_action :find_cup

  def new
    @match = @cup.matches.new
  end
  def create
    date = DateTime.strptime(match_params[:date], "%Y-%m-%dT%H:%MT%Z")
    
    @match = @cup.matches.new(match_params)
    # mysql doesn't save tz data
    @match.date = date
    @match.tzinfo = date.utc_offset

    if @match.save
      redirect_to :controller => "cups", :action => "schedule", :cup_url => @cup.cup_url
    else
      render 'new'
    end
  end

private

  def find_cup
    if session[:cup_id]
      @cup = Cup.find(session[:cup_id])
    else
      # add flash?
      redirect_to users_path
    end
  end

  def match_params
    params.require(:match).permit(:date,:home_team_id,:away_team_id,:half,:extra,:penalty,:description,:cup_id)
  end

end