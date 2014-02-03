class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :moves
  attr_accessible :symbol, :game_id, :user_id

  def opponent
    self.game.players.where('id != ?', self.id ).first
  end
end
