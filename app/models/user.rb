class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :generate_jti

  def send_reset_password_instructions
    token = set_reset_password_token
    ForgotPasswordJob.perform_later(self, token)
    token
  end
  private

  def generate_jti
    self.jti = SecureRandom.uuid if self.jti.blank?
  end


  has_many :posts, dependent: :destroy
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum role: { admin: 0, user: 2 }
  validates :role, presence: true, inclusion: { in: roles.keys }
end
