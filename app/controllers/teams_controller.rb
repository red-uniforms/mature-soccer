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

    # if user isn't member of the team
    if current_user.teams.exclude? @team
      @user_info = UserInfo.where(user: current_user.id, team: @team.id).take
      @user_info ||= UserInfo.new
      render 'join'
    end
  end

  def join
    applicant = Applicant.new
    applicant.user = current_user
    
    @team = find_team(params[:team_url])
    applicant.team = @team

    @user_info = UserInfo.new(join_params)
    @user_info.user = current_user
    @user_info.team = @team

    if applicant.valid? and @user_info.valid?
      applicant.save!
      @user_info.save!
      redirect_to action: 'show'
    else
      render 'join'
    end
  end

  def find_team(team_url)
    team = Team.find_by team_url: team_url
    if team.nil?
      render_404
    else
      team
    end
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
