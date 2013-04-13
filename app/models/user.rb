class User < ActiveRecord::Base
  include Likes
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { within: 3..25 }, if: -> { name.present? }

  def owns?(model)
    model.respond_to?(:user_id) and model.user_id == id
  end
end
