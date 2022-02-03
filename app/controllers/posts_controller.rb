# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.joins(:user).select('posts.*, users.nick_name').where('posts.parent_id is NULL')
  end

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

  def show
    # TODO: ベストな書き方を調べる
    @post = Post.joins(:user)
                .select('posts.*, users.nick_name')
                .find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
