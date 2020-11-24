class Api::V1::FriendshipController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    render json: FriendshipSerializer.new(Friendship.all)
  end

  def create
    Friendship.friend_request(current_user.id, params[:friend_id])
    render json: FriendshipSerializer.new(Friendship.all.last(2))
    # render json: FriendshipSerializer.new(Friendship.all)
  end

  def update
    Friendship.accept_friend(current_user.id, params[:friend_id])
    render json: FriendshipSerializer.new(Friendship.all.last(2))
  end
  
  def destroy
    Friendship.remove_friend(current_user.id, params[:friend_id])
    render json: FriendshipSerializer.new(Friendship.all)
  end

end
