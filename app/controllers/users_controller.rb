class UsersController < ApplicationController
  def index
    @teams = current_user.all_teams
  end
end
