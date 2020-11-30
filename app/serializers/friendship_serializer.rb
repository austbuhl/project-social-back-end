class FriendshipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :friend_id, :status, :friender_id

attribute :username do |friendship|
  friendship.user.username
end

attribute :friend_name do |friendship|
  friendship.friend.username
end

cache_options enabled: true, cache_length: 12.hours

  # belongs_to :user
  # belongs_to :friend, class_name: "User"
end