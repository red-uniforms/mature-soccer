class OrganizersController < ApplicationController
  def new
  end
  def create
    user = User.find_by email: params[:email]
    org = user.organizers.new

    cup = Cup.find(session[:cup_id])
    org.cup = cup

    # TODO
    # redirect_to ?
  end

private
  def organizer_params
    params.require(:organizer).permit(:email)
  end

end