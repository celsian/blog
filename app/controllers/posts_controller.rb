class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def show_recent
    @posts = Post.all.first(5)
    @post = @posts.shift
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to post_path(@post), flash: {success: "Post was created."}
    else
      flash[:error] = "Error: #{@post.error_messages}"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
