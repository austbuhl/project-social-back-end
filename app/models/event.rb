class Event < ApplicationRecord
  belongs_to :park
  has_many :user_events
  has_many :comments
  has_many :event_activities
  has_many :activities, through: :event_activities
  has_many :users, through: :user_events

  accepts_nested_attributes_for :activities
end
