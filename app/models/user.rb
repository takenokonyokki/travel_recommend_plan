class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable#, :validatable

  has_one_attached :image

  validates :name, presence: true

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }, on: :create
  validates :password_confirmation, presence: true, format: { with: VALID_PASSWORD_REGEX }, on: :create

  has_many :plans, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64(8)
      user.password_confirmation = user.password
      user.name = "ゲスト"
      # user.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.jpg')), filename: "default-image.jpg", content_type: 'image/jpeg')
    end
  end

  def update_with_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

end
