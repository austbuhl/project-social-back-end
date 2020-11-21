class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :username
  belongs_to :event
  belongs_to :user

  def username
    object.user.username
  end
end