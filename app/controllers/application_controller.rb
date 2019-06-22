class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit 

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  private

  def user_not_authorized
    flash[:alert] = 'Access denied'
    redirect_to(request.referrer || root_path)
  end

  # def skip_pundit?
  #   devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  # end
end
