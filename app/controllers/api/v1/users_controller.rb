class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]

  def profile
    render json: UserSerializer.new(current_user)
  end

  def index
    users = User.includes(:comments, :events, :friendships).all
    render json: UserSerializer.new(users)
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token(user_id: user.id)
      options = {
        meta: token
      }
      render json: UserSerializer.new(user, options)
    else
      render json: {error: 'failed to create user'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
