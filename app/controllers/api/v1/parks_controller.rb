class Api::V1::ParksController < ApplicationController
  skip_before_action :authorized
  
  def index
    parks = Park.all
    render json: parks
  end

end
