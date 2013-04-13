require 'active_support/concern'

module Likes
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def liked? post
    likes.where(post_id: post.id).any?
  end

  def like! post
    likes.create(post_id: post.id)

    post.liked!
  end

  def unlike! post
    likes.where(post_id: post.id).destroy_all

    post.unliked!
  end
end
