class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: current_user
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token(user_id: user.id)
      render json: {user: user, jwt: token}
    else
      render json: {error: 'failed to create user'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
