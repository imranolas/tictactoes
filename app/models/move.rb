class Move < ActiveRecord::Base
  belongs_to :player
  has_one :game, through: :player
  attr_accessible :grid_location, :player_id
  validate :location_available, :is_users_turn?, :game_incomplete?, :valid_location?

  after_create :update_game

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

  def valid_location?
    unless (0..8).include?(grid_location)
      errors.add(:grid_location, 'must be within range 0-8')
    end
  end

  private
  def update_game
    game.state = nil
    game.update_game_status
    game.last_to_play = nil
  end

end
