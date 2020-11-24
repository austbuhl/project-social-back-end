class ActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :addl_detail
  cache_options enabled: true, cache_length: 12.hours
  belongs_to :park
end
