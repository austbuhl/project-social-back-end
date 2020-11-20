class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :addl_detail
  belongs_to :park
end
