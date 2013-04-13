class LikesController < ApplicationController
  before_filter :find_post!

  def create
    respond_to do |format|
      format.html
      format.json do
        current_user.like!(@post) unless current_user.liked?(@post)

        render nothing: true, status: 202
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html
      format.json do
        current_user.unlike!(@post) if current_user.liked?(@post)

        render nothing: true, status: 202
      end
    end
  end

  private

  def find_post!
    @post = Post.find(params[:id])
  end
end
