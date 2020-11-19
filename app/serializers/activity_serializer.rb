class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :addl_detail, :park_id
  belongs_to :park
end
