class Api::V1::ParksController < ApplicationController
  skip_before_action :authorized
  
  def index
    parks = Park.all
    options = {
      include: [:activities]
    }
    render json: ParkSerializer.new(parks, options)
  end

end
