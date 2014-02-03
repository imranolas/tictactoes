class HomeController < ApplicationController
  
  def index
    @games_to_join = Game.games_to_join(current_user)
    @games_to_join.each do |game|
      game.players.build(user_id: current_user.id, symbol: 'O')
    end

    @mygames = Game.users_games(current_user)
    @completed = Game.completed_games(current_user)

  end

  def scoreboard
    @user = current_user
  end
end
