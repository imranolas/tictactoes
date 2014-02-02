class MovesController < ApplicationController
  
  def create
    @move = Move.new(params[:move])
    if @move.save
      redirect_to "/play/#{@move.player.game.id}"
    end
  end

end
