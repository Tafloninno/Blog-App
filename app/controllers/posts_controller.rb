class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.includes(comments: [:author])
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post created successfully!'
    else
      render :new, alert: 'Post could not be created.'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by_id(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy

    redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
