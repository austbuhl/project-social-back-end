class FeedChannel < ApplicationCable::Channel
  def subscribed
    puts 'SUBSCRIBED'
    p params
    feed = Event.find(params[:event])
    stream_for feed
  end

  def unsubscribed
    puts 'UNSUBSCRIBED'
  end
end
