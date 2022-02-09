# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :post_forbidden_filter, only: %i[edit update destroy]

  def index
    @posts = Post.where(parent_id: nil, deleted_at: nil).includes(:user)
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
    @author = @post.user
  end

  def edit; end

  def update
    @post.content = post_params[:content]

    if @post.save
      redirect_to @post, notice: '更新しました'
    else
      redirect_to @post, alert: '更新に失敗しました'
    end
  end

  def destroy
    @post.deleted_at = Time.current

    if @post.save
      redirect_to posts_path, notice: '投稿を削除しました'
    else
      redirect_to @post, alert: '投稿の削除に失敗しました'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_forbidden_filter
    render file: 'public/403.html', status: :forbidden if @post.user_id != current_user.id
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
