class TeamsController < ApplicationController

  def new
    @team = current_user.teams.new
  end

  def create
    @team = current_user.teams.new(team_params)
    @team.captain_user_id = current_user.id
    
    if @team.save
      # relate team with user
      @team.users << current_user
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    @team = find_team(params[:team_url])

    # if user isn't member of the team
    if current_user.teams.exclude? @team
      @user_info = current_user.user_infos.where(team: @team.id).take
      @user_info ||= current_user.user_infos.new
      render 'join'
    else
      @applicants = @team.applicants
    end
  end

  def join
    @team = find_team(params[:team_url])

    @user_info = current_user.user_infos.new(join_params)
    @user_info.team = @team

    if @user_info.valid?
      @user_info.save!
      redirect_to action: 'show'
    else
      render 'join'
    end
  end

  # approve applicant
  def approve
    team = find_team_from_user(params[:team_url])

    if current_user.id == team.captain_user_id
      user_info = team.user_infos.find(params[:user_info_id])
      user_info.applying = false

      team.users << user_info.user
      team.save!
      user_info.save!

      redirect_to team_path(team_url: team.team_url)
    else
      render staus: :forbidden
    end
  end
  # reject applyment
  def reject
    team = find_team_from_user(params[:team_url])

    if current_user.id == team.captain_user_id
      user_info = team.user_infos.find(params[:user_info_id])
      user_info.destroy!

      redirect_to team_path(team_url: team.team_url)
    else
      render staus: :forbidden
    end
  end

  def find_team(team_url)
    Team.find_by(team_url: team_url) or not_found
  end
  def find_team_from_user(team_url)
    current_user.teams.find_by(team_url: team_url) or not_found
  end
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

protected
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
  def join_params
    params.require(:user_info).permit(:phone, :student_code, :career)
  end
end
