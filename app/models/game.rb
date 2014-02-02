class Game < ActiveRecord::Base
  attr_accessible :name, :status, :players_attributes, :starting_player
  has_many :players
  has_many :users, through: :players
  has_many :moves, through: :players
  accepts_nested_attributes_for :players

  before_save :check_completed

  def capacity?
    players.reject(&:new_record?).length < 2
  end

  def playing?(id)
    players.reject(&:new_record?).map(&:user_id).include?(id)
  end

  def game_state
    state = [nil]*9
    players.each do |player|
  
      if player.moves.any?
        symbol = player.symbol
        locations = player.moves.map(&:grid_location)
        locations.each { |i| state[i] = symbol }
      end
  
    end
    state
  end

  def set_starting_player
    self.starting_player ||= players.sample.id
    self.save
  end

  def users_turn?(id)
    last_move = moves.order('created_at DESC').first
    if last_move
      players.where('id != ?', last_move.player).first.user.id == id
    else
      players.where(id: starting_player).first.user.id == id
    end
  end

  def last_player
    moves.order('created_at DESC').first.player.user
  end

  ########### Tic Tac Toe Logic #########################

  WIN_LINES = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]

  def winner
    WIN_LINES.each do |line|
      current_line = [ game_state[line[0]], game_state[line[1]], game_state[line[2]] ]
      
      unless current_line.include?(nil)
        current_line.uniq.length == 1 ? (return line) : nil
      end
    end
    nil
  end

  def completed?
    !!winner || !game_state.include?(nil)
  end

  def result
    if winner
      "Winner is #{last_player.name}"
    elsif !game_state.include?(nil)
      "Draw. No winner."
    end
  end

  private

  def check_completed
    status = :completed if completed?
  end
end