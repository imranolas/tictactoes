class Game < ActiveRecord::Base
  attr_accessible :name, :status, :players_attributes, :starting_player
  has_many :players
  has_many :users, through: :players
  has_many :moves, through: :players
  accepts_nested_attributes_for :players

  before_save :set_starting_player

######## Class methods to return game sets ########

  def self.find_games_for(user)
    self.joins(players: :user).where(users: {id: user.id})
  end

  def self.users_games(user)
    find_games_for(user).reject(&:completed?)
  end

  def self.games_to_join(user)
    # self.where(starting_player: nil)
    self.all.select(&:capacity?).reject { |game| game.players.find_by_user_id(user) }
  end

  def self.completed_games(user)
    find_games_for(user).where('status = ? OR status = ?', 'win', 'draw')
  end


####### Game methods ########

  def make_move(location)
    current_player.moves.create(grid_location: location)
    update_status
    computer_move
  end

  def computer_move
    if current_player.user.name == 'Computer' && !self.completed?
      current_player.moves.create(grid_location: available_moves.sample)
    end
      update_status
  end

  def available_moves
    moves = []
    game_state.each_index { |i| moves << i if game_state[i].nil? }
    moves
  end

  def capacity?
    players.reject(&:new_record?).length < 2
  end

  def playing?(id)
    players.reject(&:new_record?).map(&:user_id).include?(id)
  end

  def game_state
    unless @state
      @state = [nil]*9
      players.each do |player|
    
        if player.moves.any?
          symbol = player.symbol
          locations = player.moves.map(&:grid_location)
          locations.each { |i| @state[i] = symbol }
        end
    
      end
    end
    @state
  end

  def users_turn?(user)
    current_player.try(:user) == user
  end

  def last_player
    moves.order('created_at DESC').first.try(:player)
  end

  def current_player
    if last_player
      players.where('id != ?', last_player.id).first
    else
      Player.find_by_id(starting_player)
    end
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

  def who_won
    last_player if winner
  end

  def who_lost
    current_player if winner
  end

  def completed?
    ['win', 'draw'].include?(status)
  end

  def result
    if winner
      "Winner is #{last_player.user.name}"
    elsif !game_state.include?(nil)
      "Draw. No winner."
    end
  end

  def set_starting_player
    unless capacity?
      self.starting_player ||= players.sample.id
    end
  end

  def game_status
    if winner
      :win
    elsif !game_state.include?(nil)
      :draw
    else
      :pending
    end
  end

  def update_status
    self.status = game_status
    self.save
  end

end