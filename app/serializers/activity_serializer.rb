class ActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :addl_detail
  # belongs_to :park
end
