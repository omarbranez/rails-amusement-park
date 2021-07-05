class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :verified_user
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_authenticated
    !!current_user
  end

  def verified_user
    redirect_to '/' unless user_authenticated
  end
end
