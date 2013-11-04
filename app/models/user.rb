class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,:allocated_space, :password_confirmation, :remember_me, :space, :role
  # attr_accessible :title, :body
  has_many :resumes

  ROLES = %w[admin user author]
end
