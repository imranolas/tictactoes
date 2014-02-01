class Game < ActiveRecord::Base
  attr_accessible :name, :status
  has_many :players
  has_many :users, through: :players
  has_many :moves, through: :players
end
