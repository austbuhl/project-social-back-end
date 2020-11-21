class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :num_of_people, :comments, :date, :time, :park_id

  has_many :comments
  has_many :users, through: :user_events
  has_many :event_activities
end
