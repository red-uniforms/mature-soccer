class TeamsController < ApplicationController
  def new
    @team = current_user.teams.new
  end

  def create
    @team = current_user.teams.new(team_params)
    @team.captain_user_id = current_user.id
    
    if @team.save
      # relate team with user
      current_user.teams << @team
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    if params[:team_url]
      @team = current_user.teams.find_by team_url: params[:team_url]
    else
      @team = current_user.teams.find(params[:id])
    end

    if @team.nil?
      redirect_to root_path
    end
  end

  def search
  end

private
  def team_params
    params.require(:team).permit(:name, :team_url, :average_age, :gender)
  end
end
