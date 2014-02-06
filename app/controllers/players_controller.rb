class PlayersController < ApplicationController
  def create
    @player = Player.create(game_id: params[:player][:game_id], user_id: current_user.id, symbol: 'O')
    @game = Game.find(params[:player][:game_id])
    @game.save unless @game.capacity?
    redirect_to @game
  end
end
