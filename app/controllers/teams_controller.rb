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
    @team = find_team(params[:team_url])

    # if there's no such team
    if @team.nil?
      render_404
    # if user isn't member of the team
    elsif current_user.teams.exclude? @team
      render 'join'
    end
  end

  def search
  end

  def join
    applicant = Applicant.new
    applicant.user = current_user
    
    team = find_team(params[:id])
    applicant.team = team

    if applicant.save
      redirect_to root_path
    else
      redirect_to 'teams#show'
    end
  end

  def find_team(team_url)
    Team.find_by team_url: team_url
  end

protected
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

private
  def team_params
    params.require(:team).permit(:name, :team_url, :average_age, :gender, :phone, :student_code, :career, :uniform_description)
  end
end
