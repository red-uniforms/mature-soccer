class MatchesController < ApplicationController
  before_action :find_cup

  def new
    @match = @cup.matches.new
  end
  def show
    @match = @cup.matches.find(params[:id])
    @referees = @match.referees
  end
  def create
    date = DateTime.strptime(match_params[:date], "%Y-%m-%dT%H:%MT%Z")
    
    @match = @cup.matches.new(match_params)
    # mysql doesn't save tz data
    @match.date = Time.parse(date.to_s)
    @match.tzinfo = date.utc_offset

    if @match.save
      redirect_to :controller => "cups", :action => "schedule", :cup_url => @cup.cup_url
    else
      render 'new'
    end
  end
  def referee
    @match = @cup.matches.find(params[:id])
    @referee = @match.referees.new(referee_params)

    if @referee.save!
      redirect_to @match
    else
      redirect_to action: 'show'
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

  def referee_params
    params.require(:referee).permit(:organizer_id)
  end

end