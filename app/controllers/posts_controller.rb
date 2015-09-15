class PostsController < ApplicationController
  before_action :set_post, :only => [:show, :edit, :update, :destroy]

 	def index
 		@posts = Post.all
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
    @post = Post.create(post_params)

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



  private
    
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image,:title, :body)
  end
end