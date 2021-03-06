class Api::V1::CommentsController < ApplicationController
  skip_before_action :authorized, only: [:index]
  
  def index
    comments = Comment.includes(:event, :user).all
    render json: CommentSerializer.new(comments)
  end

  def create
    comment = Comment.create(user_id: current_user.id, event_id: params[:event_id], text: params[:text])
    feed = comment.event
    FeedChannel.broadcast_to feed, CommentSerializer.new(comment)
    render json: CommentSerializer.new(comment)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end


end
