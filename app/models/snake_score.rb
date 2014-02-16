class SnakeScore < ActiveRecord::Base
  belongs_to :user
  attr_accessible :score, :user_id
end
