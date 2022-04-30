class Content < ApplicationRecord

  belongs_to :plan

  has_one_attached :image

  validates :order, numericality: { only_integer: true }
  validates :hour, presence: true
  validates :minute, presence: true
  validates :place, presence: true
  validates :explanation, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :telephonenumber, presence: true
  validates :access, presence: true
  validates :businesshours, presence: true
  validates :price, presence: true
  validates :stay_time, presence: true
  validates :reservation, presence: true
  validates :rate, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
