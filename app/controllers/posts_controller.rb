# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[edit update show destroy]

  authorize_resource

  def index
    @posts = if params[:my].present?
               current_user.posts.order(:created_at).page(params[:page])
             else
               Post.not_blocked.order(:created_at).page(params[:page])
             end
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Your post successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Your post was updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Your post has been deleted.'
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
