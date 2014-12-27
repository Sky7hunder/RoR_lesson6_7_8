class PostsController < ApplicationController
  before_action :check_current_user, except: [:index, :show, :popular]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :banner
  before_action :creator_check, only: [:update, :destroy]
  before_action :set_posts, only: [:index, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @posts.default
    respond_to do |format|
      format.json { render json: @posts, except: [:updated_at, :user_id], :include => { :user => { :only => :name } } }
      format.html
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.json { render json: @post , except: [:updated_at, :user_id], :include => { :user => { :only => :name } }}
      format.html
      format.js
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @current_user_creator
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :forbidden }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @current_user_creator
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @posts.errors, status: :forbidden }
      end
    end
  end

  def popular
    @posts = Post.popular
  end

  def active
    @posts = Post.active
  end

  def upvote
    @post.upvote_by current_user
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  def downvote
    @post.downvote_by current_user
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_posts
    @posts = Post.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end

  def creator_check
    @current_user_creator = false
    if current_user.id == @post.user_id
      @current_user_creator = true
    end
  end

  def check_current_user
    redirect_to root_path unless current_user
  end
end
