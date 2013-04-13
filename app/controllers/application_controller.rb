class ApplicationController < ActionController::Base
  include NilUserDecorator
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_liked_posts_store, if: -> { not user_signed_in? }

  def current_user
    # returns original #current_user if user is signed in, otherwise returns NilUser
    super.is_a?(User) ? super : ( @current_user ||= decorate(NilUser.new) )
  end

  def user_signed_in?
    current_user.is_a?(User) ? super : false
  end

  private

  def set_liked_posts_store
    cookies['liked_posts'] ||= ''
  end

  def clear_liked_posts_store
    cookies.delete 'liked_posts'
  end
end
