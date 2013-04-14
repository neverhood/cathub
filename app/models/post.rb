class Post < ActiveRecord::Base
  belongs_to :user
  has_one :media, autosave: true, dependent: :destroy; accepts_nested_attributes_for :media
  has_many :likes

  validates :description, length: { maximum: 300 }, allow_nil: true

  scope :video, -> { joins(:media).where('media.video = ?', true) }
  scope :image, -> { joins(:media).where('media.video = ?', false) }

  def liked!
    increment! :likes_count, 1
  end

  def unliked!
    increment! :likes_count, -1
  end
end
