require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :posts
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password_hash, :presence => true


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # This is dangerous...
  # uses save! instead normal -> could throw an execption and break everything
  # super create - returns a different data type, create normally returns the 
  # object
  # def create
  #   @user = User.new(params[:user]) #be sure to group user params in erb
  #   @user.password = params[:password]  # tag password as password in erb
  #   @user.save!
  # end

end
