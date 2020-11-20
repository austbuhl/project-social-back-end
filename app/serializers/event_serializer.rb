class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :num_of_people, :activities, :comments

  has_many :comments
  # has_many :users, through: :comments
  # belongs_to :park
  # has_many :activities, through: :event_activities
  # has_many :event_activities
end
