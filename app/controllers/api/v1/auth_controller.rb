class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]
    
  def create 
      user = User.find_by(username: params[:username])
      
      if user && user.authenticate(params[:password])
          token = encode_token({user_id: user.id})
          options = {
            meta: token
          }
          render json: UserSerializer.new(user, options)
      else
          render json: {message: 'Invalid username or password' },  status: :unauthorized
      end
  end
  
end