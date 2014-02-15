class SnakeScore < ActiveRecord::Base
  belongs_to :user
  attr_accessible :score
end
