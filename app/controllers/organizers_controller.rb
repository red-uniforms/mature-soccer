class OrganizersController < ApplicationController
  def new
  end
  def create
    user = User.find_by email: organizer_params[:email] or not_found
    org = user.organizers.new

    # some errors in logic..
    cup = Cup.find(session[:cup_id])
    org.cup = cup

    org.save!
    
    redirect_to :back
  end

private
  def organizer_params
    params.require(:organizer).permit(:email)
  end

end