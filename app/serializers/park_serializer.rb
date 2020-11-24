class ParkSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :latitude, :longitude, :website, :nycParkId, :location
  cache_options enabled: true, cache_length: 12.hours

  has_many :activities
  has_many :events
end
