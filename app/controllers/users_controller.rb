class UsersController < ApplicationController
  before_filter :find_user!, only: [ :show ]

  def show
    @posts = @user.posts.includes(:user).includes(:media)
  end

  private

  def find_user!
    @user = User.find(params[:id])
  end
end
