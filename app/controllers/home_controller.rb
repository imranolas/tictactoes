class HomeController < ApplicationController
  
  skip_before_filter :redirect_to_login, only: [:index]

  def index
    render :index, layout: false
  end

  def home
    redirect_to '/login' unless current_user
  end

end
