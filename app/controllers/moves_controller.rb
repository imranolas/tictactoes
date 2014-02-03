class MovesController < ApplicationController
  
  def create
    @move = Move.create(params[:move])
    @game = @move.player.game
    @game.status = @game.game_over?
    @game.save

    redirect_to play_path(@game)
  end

end
