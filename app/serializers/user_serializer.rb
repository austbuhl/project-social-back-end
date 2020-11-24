class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username
  cache_options enabled: true, cache_length: 12.hours
  has_many :comments
  has_many :events, through: :user_events
end
