class UsersController < ApplicationController
  def index
    @teams = current_user.teams
    @organizers = current_user.organizers
  end
end
