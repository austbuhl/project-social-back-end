class EventActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :event_id, :activity_id, :name
  belongs_to :event
  belongs_to :activity

  def name
    object.activity.name
  end
end
