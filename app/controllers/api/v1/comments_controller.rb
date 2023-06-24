# app/controllers/api/v1/comments_controller.rb
class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    post = Post.find(params[:post_id])
    comments = post.comments.includes(:author)
    render json: comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
