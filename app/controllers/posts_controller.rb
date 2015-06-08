class PostsController < ApplicationController

  respond_to :html, :json

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @posts = [Post.find(params[:id])]

    @next_post = @posts.first.next.first
    @previous_post = @posts.first.previous.first

    @posts_by_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y") }

    respond_with(@posts)
  end

  def show_recent
    @posts = Post.all[0..4]
    @posts_by_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y") }

    respond_with(@posts)
  end

  def show_by_month
    month = params[:month_year][0..1].to_i
    year = params[:month_year][2..3].to_i
    @startTime = Time.new(2000+year,month,01, 0,0,0)

    @posts = Post.where(created_at: @startTime..(@startTime+1.month))
    @posts_by_month = Post.all.group_by { |post| post.created_at.strftime("%B %Y") }

    @next_month = Post.nextMonth(@posts.last)
    @previous_month = Post.previousMonth(@posts.first)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      # redirect_to post_path(@post), flash: {success: "Post was created."}
      # respond_with(@post, flash: {success: "Post was created."})

      respond_with @post do |format|
        format.html {redirect_to @post, flash: {success: "Post was created."}}
      end
    else
      flash[:error] = "Error: #{@post.error_messages}"
      render :new
    end    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    respond_with()
  end

  protected
  # In Rails 4.1 and below
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
