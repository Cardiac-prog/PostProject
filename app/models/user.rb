class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {admin: 0, moderator: 1, user: 2 }
  validates :role, presence: true, inclusion: {in: roles.keys}       
end
