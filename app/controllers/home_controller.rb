class HomeController < ApplicationController
  def index
    @games = Game.all
    @games.each do |game|
      game.players.build(user_id: current_user.id, symbol: 'O') if game.capacity?
    end
  end
end
