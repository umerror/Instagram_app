class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
  	@post = Post.new
  end  

  def show
    
  end

  def edit
    
  end

  def update  
    if @post.update(params[:post].permit(:image, :description))

      redirect_to @post
    else
      render 'edit'
    end
  end

  def create
  	@post = Post.new(permit_post)
  	if @post.save
  		flash[:success] = "Success!"
  		redirect_to post_path(@post) 
  	else
  		flash[:error] = @post.errors.full_messages
  		redirect_to new_post_path
  	end
  end

  def destroy    
    @post.destroy

    redirect_to root_path
  end

  private

    def find_post
      @post = Post.find(params[:id])
    end
  	def permit_post
  		params.require(:post).permit(:image,:description)
  		
  	end

end
