class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.friend_request(user_id, friend_id)
    Friendship.find_or_create_by(user_id: user_id, friend_id: friend_id, status: 'pending')
    Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id, status: 'pending')
  end

  def self.accept_friend(user_id, friend_id)
    Friendship.find_by(user_id: user_id, friend_id: friend_id).update(status: 'accepted')
    Friendship.find_by(user_id: friend_id, friend_id: user_id).update(status: 'accepted')
  end

  def self.remove_friend(user_id, friend_id)
    Friendship.find_by(user_id: user_id, friend_id: friend_id).destroy
    Friendship.find_by(user_id: friend_id, friend_id: user_id).destroy
  end

end