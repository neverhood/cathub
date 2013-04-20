class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [ :update, :destroy, :create ]
  before_filter :find_post!, only: [ :show, :update, :destroy ]
  before_filter :prepare_section, only: [ :index ]
  before_filter :prepare_sort, only: [ :index ]

  def index
    @posts = @section.order(@sort).page(params[:page]).includes(:user).includes(:media)
    @post  = Post.new.tap { |post| post.build_media }

    prepare_top_cats unless request.xhr?

    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: 'post', collection: @posts), last: @posts.last_page? }
      end
    end
  end

  def show
  end

  def create
    @post = Post.create(post_params)

    if @post.save
      redirect_to root_path, notice: I18n.t('flash.posts.create.notice')
    else
      redirect_to root_path, alert: I18n.t('flash.posts.create.alert')
    end
  end

  def update
    @post.update post_params

    if @post.valid?
    else
    end
  end

  def destroy
    @post.destroy

    render nothing: true, status: 202
  end

  private

  def post_params
    params.require(:post).permit(:description, media_attributes: [ :image, :url ]).merge(user_id: current_user.id)
  end

  def find_post!
    @post = Post.find(params[:id])
  end

  def prepare_section
    @section = %w(video image).include?(params[:section]) ? Post.send(params[:section].to_sym) : Post.all
  end

  def prepare_sort
    @sort = %w(likes_count).include?(params[:sort]) ? "posts.#{params[:sort]} DESC, posts.created_at DESC" : 'posts.created_at DESC'
  end

  def prepare_top_cats
    @daily_top_videos    = Post.daily(:video)
    @daily_top_images    = Post.daily(:image)
    @weekly_top_videos   = Post.weekly(:video)
    @weekly_top_images   = Post.weekly(:image)
    @all_time_top_videos = Post.all_time(:video)
    @all_time_top_images = Post.all_time(:image)
  end
end
