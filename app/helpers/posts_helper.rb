module PostsHelper
  def current_section
    %w(video image).include?(params[:section]) ? params[:section].inquiry : 'all'.inquiry
  end

  def current_sort
    %w(likes_count).include?(params[:sort]) ? params[:sort].inquiry : 'date'.inquiry
  end
end
