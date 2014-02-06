class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :players
  has_many :games, through: :players
  has_many :moves, through: :players
  has_many :scores, through: :players

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def games_won
    # self.games.where(status: :win).select { |game| game.last_player.user == self }
    self.games.joins(players: :scores).where(scores: {result: 'win'})
  end

  def games_lost
    # self.games.where(status: :win).select { |game| game.last_player.user != self }
    self.games.joins(players: :scores).where(scores: {result: 'lose'})
  end

  def games_drawn
    # self.games.where(status: :draw)
    self.games.joins(players: :scores).where(scores: {result: 'draw'})
  end

  def number_of_games_won
    scores.where(result: 'win').count
  end

  def number_of_games_lost
    scores.where(result: 'lose').count
  end

  def number_of_games_tied
    scores.where(result: 'draw').count
  end

end