class GamesController < ApplicationController

  def new
    @game = Game.new name: 'TicTacToe'
    @game.players.build user_id: current_user.id, symbol: 'X'
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to home_index_path
    else
      render :new
    end
  end

  def update
    @game = Game.find(params[:game][:id])
    @game.update_attributes(params[:game])
    @game.set_starting_player
    redirect_to home_index_path
  end

  def show
    @game = Game.find(params[:game_id])
    @current_player = @game.players.find_by_user_id(current_user.id)
    @move = @current_player.moves.build if @current_player
  end

end
