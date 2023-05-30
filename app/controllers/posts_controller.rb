class PostsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_post, only: [:edit, :update, :show, :destory]

  authorize_resource

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    #@post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private

    def set_post
      @post = Post.with_attached_files.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, files: [])
    end








end
