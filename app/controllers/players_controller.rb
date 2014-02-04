class PlayersController < ApplicationController
  def create
    @player = Player.create(params[:player])
    @game = Game.find(params[:player][:game_id])
    @game.save unless @game.capacity?
    redirect_to @game
  end
end
