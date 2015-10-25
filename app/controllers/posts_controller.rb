class PostsController < ApplicationController
  before_action :set_post, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @user = current_user
  end
 	
  def show
    render :show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    pass_params = post_params
    pass_params["user"] = current_user
    @post = Post.create(pass_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created'}
        format.json { render :show, status: :created, location: @post}
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end
  def comment
    user = current_user
    pass_params = comment_params
    if Comment.find_by_user_id_and_post_id(user.id, pass_params['post_id'])
      #render :text=>"successfully send but don't add"
      render :text=> pass_params["post_id"]
      return
    end
    pass_params['user'] = user 
    @comment = Comment.create(pass_params)
    @comment.save
    render :text=> pass_params["post_id"]
  end

  def buyCount
    pass_params = comment_params
    nbuy = buy = 0
    Comment.where(post_id: pass_params["post_id"]).find_each do |c|
      buy += 1 if c.buy
      nbuy += 1 unless c.buy
    end
    render :text => ActiveSupport::JSON.encode({ post_id: pass_params["post_id"], buy: buy,nbuy: nbuy })
  end
  
  private
    
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image,:title, :body, :user)
  end
  def comment_params
    params.require(:comment).permit(:buy, :post_id)
  end
end
