require 'active_support/concern'

module NilUserDecorator
  extend ActiveSupport::Concern

  def decorate(nil_user)
    raise 'NilUser required' unless nil_user.is_a?(NilUser)

    accessor = instance_variable_get(:@_request)
    nil_user.class.send(:define_method, 'cookies', proc { accessor.cookie_jar })

    class << nil_user
      # the below methods are cookie-dependent
      def like! post
        cookies['liked_posts'] = { value: liked_post_ids.tap { |ids| ids << post.id.to_s }.join(','), expires: 1.year.from_now }

        post.liked!
      end

      def unlike! post
        cookies['liked_posts'] = { value: liked_post_ids.tap { |ids| ids.delete(post.id.to_s) }.join(','), expires: 1.year.from_now }

        post.unliked!
      end

      def liked? post
        liked_post_ids.include? post.id.to_s
      end

      private

      def liked_posts
        cookies['liked_posts']
      end

      def liked_post_ids
        liked_posts.split(',')
      end
    end

    nil_user
  end
end
