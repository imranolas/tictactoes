class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :players
  has_many :games, through: :players
  has_many :moves, through: :players
  has_many :scores, through: :players
  has_one :snake_score

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