class GroupsController < ApplicationController
  before_action :find_cup

  def show
    @group = @cup.groups.find(params[:id]) or not_found
  end

  def edit
    @team = Team.find(group_params[:team_id])

    if @cup.teams.include? @team

      @group = @cup.groups.find(params[:id])
      @group.teams << @team

    end

    redirect_to :action => "show", :id => params[:id]
  end

  def new
    @group = @cup.groups.new
  end

  def create
    @group = @cup.groups.new(group_params)

    if @group.save
      redirect_to :action => "show", :id => @group.id
    else
      render 'new'
    end
  end

  def destroy
    @group = @cup.groups.find(params[:id])
    @group.destroy!

    redirect_to :controller => 'cups', :action => 'rank', :cup_url => @cup.cup_url
  end

private

  def group_params
    params.require(:group).permit(:name, :max_team, :team_id)
  end

  def find_cup
    if session[:cup_id]
      @cup = Cup.find(session[:cup_id])
    else
      # add flash?
      redirect_to users_path
    end
  end
end