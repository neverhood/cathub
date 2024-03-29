require 'youtube'
require 'validators/file_size_validator'

class Media < ActiveRecord::Base
  include Youtube

  attr_accessor :processing_required # carrierwave processing required

  belongs_to :post

  before_validation :strip_media_attributes!
  before_save       :set_embeddable_youtube_url, if: :video?

  mount_uploader :image, ImageUploader

  validate  :valid_youtube_video, if: :video?
  validates :url, presence: true, if: :video?
  validates :image, file_size: { maximum: 5.megabytes.to_i }, allow_nil: true

  private

  def strip_media_attributes!
    if image.present?
      self.video = false
      self.url   = nil
    else
      self.image = nil
      self.video = true
    end
  end

  def valid_youtube_video
    errors.add(:video, I18n.t('activerecord.errors.models.media.video.invalid')) unless valid_youtube_video?
  end

  def set_embeddable_youtube_url
    self.url = embeddable_video_url
  end
end
