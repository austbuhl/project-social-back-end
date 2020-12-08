class Api::V1::FriendshipController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    render json: FriendshipSerializer.new(Friendship.includes(:friend, :user).all)
  end

  def create
    Friendship.friend_request(current_user.id, params[:friend_id])
    render json: FriendshipSerializer.new(Friendship.all.last(2))
    # render json: FriendshipSerializer.new(Friendship.all)
  end

  def update
    # friendship = Friendship.find_by({user_id: current_user.id, friend_id: params[:friend_id]})
    Friendship.accept_friend(current_user.id, params[:friend_id])
    render json: FriendshipSerializer.new(Friendship.order(:updated_at).last(2))
  end
  
  def destroy
    first = Friendship.find_by({user_id: current_user.id, friend_id: params[:id]})
    second = Friendship.find_by({user_id: params[:id], friend_id: current_user.id})
    Friendship.remove_friend(current_user.id, params[:id])
    render json: {first: first, second: second, userId: current_user.id, friendId: params[:id].to_i}
  end

end
