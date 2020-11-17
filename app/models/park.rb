class Park < ApplicationRecord
  has_many :activities
  has_many :events
end
