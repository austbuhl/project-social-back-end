class FriendshipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :friend_id, :status

attribute :username do |friendship|
  friendship.user.username
end

attribute :friend_name do |friendship|
  friendship.friend.username
end

  # belongs_to :user
  # belongs_to :friend, class_name: "User"
end