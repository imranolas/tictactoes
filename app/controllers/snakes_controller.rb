class SnakesController < ApplicationController
  def index
  end

  def create
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
    @scores = SnakeScore.all
    @user_score = current_user.snake_score
  end
end
