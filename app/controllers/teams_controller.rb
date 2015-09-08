class TeamsController < ApplicationController
  before_action :find_team, only: [:show, :captain, :join, :approve, :reject]
  before_action :authenticate_captain!, only: [:captain, :approve, :reject]

  def new
    @team = current_user.teams.new
  end

  def create
    captain = current_user.captains.new

    @team = current_user.teams.new(team_params)
    
    if @team.save
      # relate team with user
      # @team.users << current_user
      @team.captains << captain
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    #@team = find_team(params[:team_url])

    # if user isn't member of the team
    if @team.all_users.exclude? current_user
      @user_info = current_user.user_infos.where(team: @team.id).take
      @user_info ||= current_user.user_infos.new
      render 'join'
    else
      @applicants = @team.applicants

      if @team.members.map{ |a| a.user }.exclude? current_user
        @user_info = current_user.user_infos.new
      end
    end
  end

  def captain
    @user_info = current_user.user_infos.new(join_params)
    @user_info.team = @team
    @user_info.applying = false

    if @user_info.valid?
      @user_info.save!
      redirect_to action: 'show'
    else
      render 'show'
    end
  end

  def join

    if current_user.user_infos.where(team_id: @team.id).any?
      redirect_to action: 'show'
    else
      @user_info = current_user.user_infos.new(join_params)
      @user_info.team = @team

      if @user_info.valid?
        @user_info.save!
        redirect_to action: 'show'
      else
        render 'join'
      end
    end
  end

  def approve
    if @team.captains.map{ |cap| cap.user }.include? current_user
      user_info = @team.user_infos.find(params[:user_info_id])
      user_info.applying = false

      @team.users << user_info.user
      @team.save!
      user_info.save!

      redirect_to team_path(team_url: @team.team_url)
    else
      render staus: :forbidden
    end
  end

  def reject
    if @team.captains.map{ |cap| cap.user }.include? current_user
      user_info = @team.user_infos.find(params[:user_info_id])
      user_info.destroy!

      redirect_to team_path(team_url: @team.team_url)
    else
      render staus: :forbidden
    end
  end

protected
  def find_team_from_user(team_url)
    current_user.teams.find_by(team_url: team_url) or not_found
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

private
  def find_team
    @team = Team.find_by(team_url: params[:team_url]) or not_found

    if session
      session[:team_id] ||= @team.id
    end
  end

  def team_params
    params.require(:team).permit(:name, :team_url, :average_age, :gender, :phone, :student_code, :career, :uniform_description)
  end
  def join_params
    params.require(:user_info).permit(:phone, :student_code, :career)
  end
  def authenticate_captain!
    @team.captains.map{ |cap| cap.user }.include? current_user or render_403
  end
end