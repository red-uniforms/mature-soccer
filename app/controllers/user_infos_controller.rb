class UserInfosController < ApplicationController
  def destroy
    user_info = UserInfo.find(params[:id])
    
    if user_info.user == current_user
      applicant = Applicant.where(user: user_info.user.id, team: user_info.team.id).take

      user_info.destroy!
      applicant.destroy!
    end

    redirect_to :back
  end
end
