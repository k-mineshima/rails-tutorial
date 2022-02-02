# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to root_path, notice: '投稿しました'
    else
      redirect_to new_posts_path, alert: '投稿に失敗しました'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
