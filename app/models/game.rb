class Game < ActiveRecord::Base
  attr_accessible :name, :status, :players_attributes
  has_many :players
  has_many :users, through: :players
  has_many :moves, through: :players
  accepts_nested_attributes_for :players

  def capacity?
    self.players.reject(&:new_record?).length < 2
  end

  def playing?(id)
    self.players.reject(&:new_record?).map(&:user_id).include?(id)
  end

end
