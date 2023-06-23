class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user

    if @post.save

      redirect_to "/users/#{current_user.id}/posts", notice: 'Post created successfully!'
    else
      render :new, alert: 'Post could not be created.'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @posts = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all # delete all comments associated with the post
    @post.destroy # delete the post itself
    redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
