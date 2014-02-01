class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end