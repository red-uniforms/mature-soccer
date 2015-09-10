class UsersController < ApplicationController
  def index
    @teams = current_user.all_teams
    @organizers = current_user.organizers

    @cups = []
    current_user.all_teams.each do |t|
      @cups += t.team_applicants
    end
  end
end
