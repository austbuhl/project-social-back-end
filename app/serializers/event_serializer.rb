class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :num_of_people, :date, :time

  belongs_to :park
  has_many :comments
  has_many :users, through: :user_events
  has_many :activities, through: :event_activities
end
