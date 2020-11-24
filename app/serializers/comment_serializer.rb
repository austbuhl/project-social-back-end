class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :text, :created_at

  belongs_to :event
  belongs_to :user
  cache_options enabled: true, cache_length: 12.hours

  
end
