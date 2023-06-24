class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    User.current_user(session)
  end
end
