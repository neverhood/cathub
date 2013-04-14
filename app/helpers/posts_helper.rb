module PostsHelper
  def current_section
    %w(video image).include?(params[:section]) ? params[:section].inquiry : 'all'.inquiry
  end

  def current_sort
    %w(likes_count).include?(params[:sort]) ? params[:sort].inquiry : 'date'.inquiry
  end

  def post_description(post)
    "#{ post.description.present?? truncate(post.description, length: 50) : t('.no_description') } #{ t '.by', name: truncate(post.user.name, length: 20) } : <span class='top-entry-likes'>#{post.likes_count} <i class='icon-heart'></i></span>".html_safe
  end
end
