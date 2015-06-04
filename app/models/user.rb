class User < ActiveRecord::Base

  has_secure_password

  validates :username, :email, uniqueness: true
  validates :username, :first_name, :last_name, :password_digest, presence: true
  validates :password_digest, :username, length: { minimum: 6 }

  has_many :event_ownerships
  has_many :events, through: :event_ownerships

end
