class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :players
  has_many :games, through: :players
  has_many :moves, through: :players

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def games_won
    self.games.where(status: :win).select { |game| game.last_player.user == self }
  end

  def games_lost
    self.games.where(status: :win).select { |game| game.last_player.user != self }
  end

  def games_drawn
    self.games.where(status: :draw)
  end

end