class User < ActiveRecord::Base
  include Likes
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [ :vkontakte, :facebook ]

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { within: 3..25 }, if: -> { name.present? }

  before_save -> { self.set_own_password = true if persisted? and encrypted_password_changed? }, unless: :set_own_password?

  def owns?(model)
    model.respond_to?(:user_id) and model.user_id == id
  end

  def self.find_for_facebook_oauth access_token
    if user = User.where(provider_url: access_token.info.urls.Facebook).first
      user
    else
      User.create(provider: access_token.provider, set_own_password: false, provider_url: access_token.info.urls.Facebook, name: access_token.extra.raw_info.name, :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(provider_url: access_token.info.urls.Vkontakte).first
      user
    else
      User.create(provider: access_token.provider, set_own_password: false, provider_url: access_token.info.urls.Vkontakte, name: access_token.info.name, email: "#{ access_token.info.nickname }@vk.com", password: Devise.friendly_token[0,20])
    end
  end
end
