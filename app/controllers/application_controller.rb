class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_403
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/403", :layout => false, status: 403 }
      format.any  { head :forbidden }
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :age, :email, :password, :current_password) }
    end

end
