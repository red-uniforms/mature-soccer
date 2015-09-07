class CupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  before_action :find_cup, only: [:show, :schedule, :rank, :records, :organize, :approve, :reject, :notices]
  before_action :authenticate_organizer!, only: [:organize, :approve, :reject]

  def show
    if current_user
      # already done in before_action
      # session[:cup_id] = @cup.id

      @captain_teams = current_user.captain_teams
      @applying_teams = @cup.applying_teams
      @user_applying_teams = @captain_teams&@applying_teams

      @new_team_applicant = @cup.team_applicants.new
    end
  end

  def new
    @cup = Cup.new
  end

  def create
    @cup = Cup.create(cup_params)

    organizer = current_user.organizers.new
    organizer.cup = @cup

    if @cup.valid?
      @cup.save
      organizer.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def join
    team_applicant = TeamApplicant.new(team_applicant_params)
    team_applicant.cup_id = session[:cup_id]
    team_applicant.save!

    redirect_to :back
  end

  def schedule
  end
  def rank
    @groups = @cup.groups
  end
  def records
  end

  def notices
    @notices = @cup.notices.order(created_at: :desc)
  end

  # only organizers can access
  def organize
    @organizer = Organizer.new
  end
  def approve
    team_applicant = @cup.team_applicants.find(params[:team_applicant_id]) or not_found
    team_applicant.applying = false
    team_applicant.save!

    redirect_to :back
  end
  def reject
  end

private
  def cup_params
    params.require(:cup).permit(:name, :cup_url, :max_team, :description, :has_league, :has_tournament)
  end
  def team_applicant_params
    params.require(:team_applicant).permit(:team_id)
  end
  def find_cup
    @cup = Cup.find_by(cup_url: params[:cup_url]) or not_found

    if session
      session[:cup_id] ||= @cup.id
    end
  end
  def authenticate_organizer!
    @cup.organizers.map{ |o| o.user }.include? current_user or render_403
  end
end