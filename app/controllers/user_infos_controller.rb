class UserInfosController < ApplicationController
  def destroy
    user_info = UserInfo.find(params[:id])
    applicant = Applicant.where(user: user_info.user.id, team: user_info.team.id).take
    
    user_info.destroy!
    applicant.destroy!

    redirect_to :back
  end
end
