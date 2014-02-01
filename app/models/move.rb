class Move < ActiveRecord::Base
  belongs_to :player
  attr_accessible :grid_location
end
