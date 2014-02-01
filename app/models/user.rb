class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :players
  has_many :games, through: :players
  has_many :moves, through: :players

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end
