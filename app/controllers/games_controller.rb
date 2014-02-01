class GamesController < ApplicationController

  def new
    @game = Game.new name: 'TicTacToe'
    @game.players.build user_id: current_user.id, symbol: 'X'
    # raise
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
    redirect_to home_index_path

  end

end
