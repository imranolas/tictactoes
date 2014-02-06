class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :moves
  has_many :scores
  attr_accessible :symbol, :game_id, :user_id

  validate :too_many_players

  def too_many_players
   if Player.where(game_id: game_id).count == 2
      errors.add(:game_id, 'already has players.')
    end
  end

end
