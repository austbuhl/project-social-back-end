class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]
    
  def create 
      user = User.find_by(username: params[:username])
      
      if user && user.authenticate(params[:password])
          token = encode_token({user_id: user.id})
          render json: {user: user, jwt: token}
      else
          render json: { message: 'Invalid username or password' }
      end
  end
  
end