class EventActivitySerializer < ActiveModel::Serializer
  attributes :id, :event_id, :activity_id, :activity
  belongs_to :event
  belongs_to :activity
end
