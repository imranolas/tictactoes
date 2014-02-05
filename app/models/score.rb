class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  attr_accessible :result, :player_id, :game_id

  validates :player_id, uniqueness: {scope: :game_id}
end
