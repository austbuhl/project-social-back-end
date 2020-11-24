class EventActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :event_id, :activity_id, :name
  belongs_to :event
  belongs_to :activity
  cache_options enabled: true, cache_length: 12.hours

  def name
    object.activity.name
  end
end
