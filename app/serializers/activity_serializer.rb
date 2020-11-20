class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :addl_detail, :park
  belongs_to :park
end
