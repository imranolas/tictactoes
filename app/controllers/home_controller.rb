class HomeController < ApplicationController
  
  def index
    render :index, layout: false
  end

  def home
    redirect_to '/login' unless current_user
  end

end
