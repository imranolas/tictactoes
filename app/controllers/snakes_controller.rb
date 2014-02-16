class SnakesController < ApplicationController
  def index
    redirect_to '/login' unless current_user
  end

  def create
    redirect_to '/login' unless current_user
    @score = current_user.snake_score || SnakeScore.new(user_id: current_user.id )
    if params[:score].to_i > @score.score.to_i
      @score.score = params[:score] 
    end
      @score.save

    respond_to do |format|
      format.html { redirect_to :index }
      format.json { render :json => @score }
    end
  end

  def scores
    redirect_to '/login' unless current_user
    @scores = SnakeScore.order('score DESC').limit(20)
    @user_score = current_user.snake_score
  end
end
