class GamesController < ApplicationController
  load_and_authorize_resource

    def index
    @games_to_join = Game.games_to_join(current_user).page(params[:join_games_page])
    @games_to_join.each do |game|
      game.players.build(user_id: current_user.id, symbol: 'O')
    end

    @mygames = Game.users_games(current_user).page(params[:current_game_page])
    @completed = Game.completed_games(current_user).page(params[:page])

  end

  def scoreboard
    @user = current_user
  end

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

  def create_computer_game
    @game = Game.create(name: 'TicTacToe')
    @game.players.create(user_id: current_user.id, symbol: 'X')
    @game.players.create(user_id: 1, symbol: 'O')
    @game.save
    @game.computer_move
    redirect_to @game
  end

  def update
    if params[:id]
      @game = Game.find(params[:id])
      @game.make_move(params[:game][:grid_location])
      redirect_to @game
    else
      @game = Game.find(params[:game][:id])
      @game.update_attributes(params[:game])
      redirect_to home_index_path
    end
  end

  def show
    @game = Game.find(params[:id])
    # @current_player = @game.current_player
    # @moves = @current_player.moves.build if @current_player
  end

end
