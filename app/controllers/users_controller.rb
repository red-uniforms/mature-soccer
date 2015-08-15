class UsersController < ApplicationController
  def index
    @teams = current_user.teams
  end
end
