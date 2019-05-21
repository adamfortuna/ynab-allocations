class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(email: ENV['YNAB_EMAIL'])
  end
end
