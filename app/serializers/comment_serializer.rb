class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :text, :created_at
  belongs_to :event
  belongs_to :user

  def username
    object.user.username
  end
end
