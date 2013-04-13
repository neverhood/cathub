module Youtube
  extend self

  VIDEO_ID_REGEXP = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-_]+)/
  VALIDATOR_URL   = 'http://gdata.youtube.com/feeds/api/videos/'
  EMBEDDABLE_URL  = 'http://www.youtube.com/embed/'

  def video_id
    @video_id ||= url.match(VIDEO_ID_REGEXP)[1] || ''
  end

  def valid_youtube_video?
    begin
      true if open(video_validation_url)
    rescue
      false
    end
  end

  private

  def video_validation_url
    VALIDATOR_URL + video_id
  end

  def embeddable_video_url
    EMBEDDABLE_URL + video_id
  end
end
