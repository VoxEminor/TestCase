# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.email
    puts @comment.inspect
    if @comment.save
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @comment.post #post_path(@post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
