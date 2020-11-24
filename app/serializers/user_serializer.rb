class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username
  has_many :comments
  has_many :events, through: :user_events
  has_many :friendships
  # has_many :friends, through: :friendships

  cache_options enabled: true, cache_length: 12.hours
end
