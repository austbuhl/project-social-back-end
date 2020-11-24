class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :num_of_people, :date, :time
  cache_options enabled: true, cache_length: 12.hours
  belongs_to :park
  has_many :comments
  has_many :users, through: :user_events
  has_many :activities, through: :event_activities
end
