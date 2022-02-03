# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.joins(:user)
                 .select('posts.*, users.nick_name')
                 .where('posts.parent_id is NULL AND posts.deleted_at is NULL')
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
    @current_user = current_user

    # TODO: 切り出せないか調べる
    render file: 'public/404.html', status: :not_found unless @post.deleted_at.nil?
  end

  def edit
    @post = Post.find(params[:id])

    # TODO: 切り出せないか調べる
    render file: 'public/403.html', status: :forbidden if @post.user_id != current_user.id
    render file: 'public/404.html', status: :not_found unless @post.deleted_at.nil?
  end

  def update
    @post = Post.find(params[:id])

    # TODO: 切り出せないか調べる
    render file: 'public/403.html', status: :forbidden if @post.user_id != current_user.id
    render file: 'public/404.html', status: :not_found unless @post.deleted_at.nil?

    @post.content = post_params[:content]

    if @post.save
      redirect_to @post, notice: '更新しました'
    else
      redirect_to @post, alert: '更新に失敗しました'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    # TODO: 切り出せないか調べる
    render file: 'public/403.html', status: :forbidden if @post.user_id != current_user.id
    render file: 'public/404.html', status: :not_found unless @post.deleted_at.nil?

    @post.deleted_at = Time.current

    if @post.save
      redirect_to posts_path, notice: '投稿を削除しました'
    else
      redirect_to @post, alert: '投稿の削除に失敗しました'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
