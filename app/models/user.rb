require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :posts
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password_hash, :presence => true
  validates :username, :presence => true


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
