class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username

  has_many :comments
  has_many :events, through: :user_events
end
