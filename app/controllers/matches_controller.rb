class MatchesController < ApplicationController
  before_action :find_cup
  before_action :authenticate_organizer!, only: [:new,:create,:referee,:destroy,:record,:status]

  def new
    @match = @cup.matches.new
  end
  def show
    @match = @cup.matches.find(params[:id])
    @referees = @match.referees
    @players = @match.users
    @events = Event.where(match_id: @match.id).order(created_at: :desc)
    @event = @match.events.new

    if @referees.map{ |r| r.organizer }.include? current_user.organizers.where(cup_id: @cup.id).take
      @is_ref = true
    else
      @is_ref = false
    end
  end
  def create
    date = DateTime.strptime(match_params[:date], "%Y-%m-%dT%H:%MT%Z %p")
    
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

  # changes match status 0 1 half 2 interval 3 extrahalf 4 pk
  def status
    @match = @cup.matches.find(params[:id])
    if %w(0 half interval extrahalf).include? @match.status
      @match.started_at = Time.now
    end

    @match.status = @match.statuses[ @match.statuses.index(@match.status) + 1 ]
    @match.save!

    if @match.status == "end"
      @match.cup.groups.each do |g|
        if g.teams.include? @match.home_team or g.teams.include? @match.away_team
          g.reset_rows
          g.update_rows
          break
        end
      end
    end

    redirect_to action: 'show'
  end

  def record
    @match = @cup.matches.find(params[:id])
    event = @match.events.new(event_params)

    if event.save
      @match.save
    end

    redirect_to action: 'show'
  end
  def player
    # 검인
    @match = @cup.matches.find(params[:id])
    @user = User.find(params[:user_id])

    @match.users << @user

    # redirect_to action: 'show'
    render plain: "success", :status => 200
  end
  def destroy
    match = @cup.matches.find(params[:id])
    match.destroy!
    
    redirect_to :controller => "cups", :action => "schedule", :cup_url => @cup.cup_url
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

  def event_params
    params.require(:event).permit(:event_type,:user_id,:when,:time)
  end

  def authenticate_organizer!
    @cup.organizers.map{ |o| o.user }.include? current_user or render_403
  end

end