class ParkSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :website, :nycParkId, :location, :activities, :events
  has_many :activities
  has_many :events
end
