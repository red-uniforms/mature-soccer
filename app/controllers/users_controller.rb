class UsersController < ApplicationController
  def index
    @teams = current_user.all_teams
    @organizers = current_user.organizers
  end
end
