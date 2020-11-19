class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :num_of_people, :park_id
  belongs_to :park
end
