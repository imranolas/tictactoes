class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :moves
  attr_accessible :symbol, :game_id, :user_id
end
