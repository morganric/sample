class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :embed, :play, :download, :player, :card]
  before_filter :authenticate_user!,  except: [:embed, :index, :show, :tag, :featured, :track, :buy, :short, :artist, :provider, :search, :embed, :latest, :play, :player, :card]

  after_filter :allow_iframe

  include ApplicationHelper
  require 'itunes-search-api'

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end


  def featured
    @posts = Post.where(featured: true)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    if @post.disabled
      redirect_to :root, notice: 'Sorry, this post has been disabled.'
    end

    @number = 0
    @post.views = @post.views.to_i + 1
    @post.save
  end

   def embed
    @number = 0
    render layout: "embed"
  end


  def player
    @number = 0
    render layout: "embed"
  end


  def card
    @number = 0
    render layout: "embed"
  end


  # GET /posts/1
  # GET /posts/1.json
  def artist
    @artist = deparametrize(params[:artist]).titleize
    @posts = Post.where("samples like ?", "%#{@artist}%").where(hidden: false)
  end

   # GET /posts/1
  # GET /posts/1.json
  def track
    @track = deparametrize(params[:track]).titleize
    @posts = Post.where("samples like ?", "%#{@track}%").where(hidden: false)
  end

  def play
    @post.plays = @post.plays.to_i + 1

    respond_to do |format|
     if @post.save
       format.json { render :show, status: :ok, location: @post }
     else
       format.html { render action: 'new' }
       format.json { render json: @post.errors, status: :unprocessable_entity }
     end
   end
  end

  def download
    @post.downloads = @post.downloads.to_i + 1

    respond_to do |format|
     if @post.save
       format.json { render :show, status: :ok, location: @post }
     else
       format.html { render action: 'new' }
       format.json { render json: @post.errors, status: :unprocessable_entity }
     end
   end
  end


  def tag
    @tag = deparametrize(params[:tag]).downcase
    @posts = Post.tagged_with(@tag).where(hidden: false)

  end

  def buy
    @track = params[:track]
    @songs = ITunesSearchAPI.search(:term => @track, :country => "US", :media => "music")
    @song = @songs.first

    unless @song.blank?
       @song_url = @song["trackViewUrl"]
      redirect_to ItunesAffiliateLink.create_link(@song_url, "track_list&app=itunes")
    else 
      redirect_to :back, notice: "Sorry, #{@track} is not available." 
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
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOWALL"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def admin_only
      unless current_user.admin? 
        redirect_to :root, :alert => "Access denied."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :user_id, :description, :samples, :image, :audio, :tag_list, :slug, :hidden, :disabled, :plays, :views, :slug, :featured, :hide_samples, :downloads, :downloadable)
    end
end
