class Api::V1::CommentsController < ApplicationController
  skip_before_action :authorized, only: [:index]
  
  def index
    comments = Comment.all
    render json: comments
  end

  def create
    comment = Comment.create(user_id: current_user.id, event_id: params[:event_id], text: params[:text])
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end


end
