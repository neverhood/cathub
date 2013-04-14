module PostsHelper
  def current_section
    %w(video image).include?(params[:section]) ? params[:section].inquiry : 'all'.inquiry
  end
end
