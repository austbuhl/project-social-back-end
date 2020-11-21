class ParkSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, :name, :latitude, :longitude, :website, :nycParkId, :location
  has_many :activities
  # has_many :events
end
