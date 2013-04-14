class Post < ActiveRecord::Base
  belongs_to :user
  has_one :media, autosave: true, dependent: :destroy; accepts_nested_attributes_for :media
  has_many :likes

  validates :description, length: { maximum: 300 }, allow_nil: true

  scope :video, -> { joins(:media).where('media.video = ?', true) }
  scope :image, -> { joins(:media).where('media.video = ?', false) }
  scope :popularity, -> { order('posts.likes_count DESC') }

  # TOPS
  scope :daily,    -> (type) { send(type).where('posts.created_at >= ?', 1.day.ago).limit(5).popularity }
  scope :weekly,   -> (type) { send(type).where('posts.created_at >= ?', 7.day.ago).limit(5).popularity }
  scope :all_time, -> (type) { send(type).limit(5).popularity }

  def liked!
    increment! :likes_count, 1
  end

  def unliked!
    increment! :likes_count, -1
  end
end
