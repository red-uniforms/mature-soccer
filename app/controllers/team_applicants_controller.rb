class TeamApplicantsController < ApplicationController
  def create
  end

  def destroy
    team_applicant = TeamApplicant.find(params[:id])

    if current_user.captain_teams.include? team_applicant.team
      team_applicant.destroy!
      redirect_to :back
    else
      render status: :forbidden
    end
  end
end
