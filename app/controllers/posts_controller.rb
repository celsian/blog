class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def show_recent
    @posts = Post.all[0..4]
    @posts_by_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y") }
  end

  def show_by_month
    month_year = params[:month_year].split("")
    month = (month_year[0] + month_year[1]).to_i
    year = (month_year[2] + month_year[3]).to_i
    startTime = Time.new(2000+year,month,01, 0,0,0)

    @posts = Post.where(created_at: startTime..(startTime+1.month))
    @posts_by_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y") }
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
