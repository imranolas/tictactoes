class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :winning_square?
    private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      @current_user = nil
    end
  end

  def winning_square?(game, location)
    game.winner.include?(location) if game.completed?
  end
end
