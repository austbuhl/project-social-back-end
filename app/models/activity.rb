class Activity < ApplicationRecord
  belongs_to :park
  has_many :event_activities
end
