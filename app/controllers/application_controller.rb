class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :winning_square?
    
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def after_sign_in_path_for(resource)
    welcome_path
  end
  
  private

  def winning_square?(game, location)
    game.winner.include?(location) if game.status == 'win'
  end

end
