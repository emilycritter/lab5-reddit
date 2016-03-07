class PostsController < ApplicationController
  def index
    if params[:search_text].present?
      @posts = Post.where("title ILIKE '%#{params[:search_text]}%'").order("vote_count desc")
    else
      @posts = Post.all.order("vote_count desc")
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(25)
    @page =  params[:page].to_i
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by id: params[:id]

    @comment = Comment.new
    @comment.post = @post
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.vote_count = 0
    @post.photo = params[:post][:photo]
    @post.link_url = params[:post][:link_url]
    @post.added_by = params[:post][:added_by]

    if @post.save
      redirect_to root_path
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
    @post.photo = params[:post][:photo]
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
    redirect_to root_path
  end

  def create_comment
    @post = Post.find_by id: params[:id]
    @comment = Comment.new

    @comment.comment_text = params[:comment][:comment_text]
    @comment.author = params[:comment][:author]
    @comment.post_id = @post.id
    # save it
    if @comment.save
      redirect_to post_path(id: @post.id)
    else
      render :show
    end
  end

  def up_vote_count
    @posts = Post.all
    @post = Post.find_by id: params[:id]
    @post.vote_count += 1
    @post.save
    redirect_to root_path
  end

  def down_vote_count
    @posts = Post.all
    @post = Post.find_by id: params[:id]
    @post.vote_count -= 1
    @post.save
    redirect_to root_path
  end

end
