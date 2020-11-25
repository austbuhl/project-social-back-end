class User < ApplicationRecord
  has_many :user_events
  has_many :comments
  has_many :events, through: :user_events

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_secure_password
end
