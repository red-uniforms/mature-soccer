class CupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @cup = find_cup(params[:cup_url])

    if current_user
      session[:cup_id] = @cup.id

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
    @cup = find_cup(params[:cup_url])
  end

  def approve
  end
  def reject
  end

protected
  def find_cup(cup_url)
    Cup.find_by(cup_url: cup_url) or not_found
  end

private
  def cup_params
    params.require(:cup).permit(:name, :cup_url, :max_team, :description, :has_league, :has_tournament)
  end
  def team_applicant_params
    params.require(:team_applicant).permit(:team_id)
  end
end