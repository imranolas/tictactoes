class Move < ActiveRecord::Base
  belongs_to :player
  has_one :game, through: :player
  attr_accessible :grid_location, :player_id
  validate :location_available, :is_users_turn?, :game_incomplete?

  def location_available
    unless game.available_moves.include?(grid_location)
      errors.add(:grid_location, "already taken.")
    end
  end

  def is_users_turn?
    unless game.current_player.id == player_id
      errors.add(:player_id, 'is not the current player')
    end
  end

  def game_incomplete?
    errors.add(:player_id, "game is complete") if game.completed?
  end

end
