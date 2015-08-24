class UserInfosController < ApplicationController
  def destroy
    user_info = current_user.user_infos.find(params[:id])
    user_info.destroy!

    redirect_to :back
  end
end
