class PostsController < ApplicationController
  def index
    @posts = Post.all.order("vote_count desc")
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by id: params[:id]
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.vote_count = params[:post][:vote_count]
    @post.photo_id = params[:post][:photo_id]
    @post.link_url = params[:post][:link_url]
    @post.added_by = params[:post][:added_by]

    if @post.save
      redirect_to root
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by id: params[:id]
  end

  def update
    @post = Post.find_by id: params[:id]
    @post.title = params[:post][:title]
    @post.vote_count = params[:post][:vote_count]
    @post.photo_id = params[:post][:photo_id]
    @post.link_url = params[:post][:link_url]
    @post.added_by = params[:post][:added_by]

    if @post.save
      redirect_to post_path(id: @post.id)
    else
      render :edit
    end
  end

  def delete
    @post = Post.find_by id: params[:id]
    @post.destroy
    redirect_to root
  end

  def create_comment
    @post = Post.find_by id: params[:id]
    @comment = Comment.new

    @comment.comment_text = params[:comment][:comment_text]
    @comment.post_id = @post.id
    # save it
    if @comment.save
      redirect_to post_path(id: @post.id)
    else
      render :show
    end
  end

  def up_vote_count
    @post = Post.find_by id: params[:id]
    @post.vote_count += 1
    redirect_to root
  end

  def down_vote_count
    @post = Post.find_by id: params[:id]
    @post.vote_count -= 1
    redirect_to root
  end
end
