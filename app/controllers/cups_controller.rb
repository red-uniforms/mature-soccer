class CupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
  def show
    @cup = find_cup(params[:cup_url])
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

protected
  def find_cup(cup_url)
    Cup.find_by(cup_url: cup_url) or not_found
  end

private
  def cup_params
    params.require(:cup).permit(:name, :cup_url, :max_team, :description, :has_league, :has_tournament)
  end

end
