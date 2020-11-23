class Api::V1::EventsController < ApplicationController
  skip_before_action :authorized, only: [:index]
  
  def index
    events = Event.includes(:park, :comments, :users, :activities).all
    # options = {
    #   include: [:comments]
    # }
    render json: EventSerializer.new(events)
  end

  def show
    event = Event.find(params[:id])
    render EventSerializer.new(event)
  end

  def create
    event = Event.create(event_params)
    park = Park.find(event_params[:park_id])
    params[:event][:activities].each do |activity|
      foundActivity = Activity.find_by(name: activity, park: park)
      EventActivity.create(event: event, activity: foundActivity)
    end
    render json: EventSerializer.new(event)
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    render json: event
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: event
  end

  def rsvp
    event = Event.find(params[:event][:event_id])
    UserEvent.find_or_create_by(event: event, user_id: current_user.id)
    render json: EventSerializer.new(event)
  end

  
  private
  
  def event_params
    params.require(:event).permit(:name, :description, :num_of_people, :date, :time, :park_id, activities:[:name])
  end

end
