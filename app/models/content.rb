class Content < ApplicationRecord

  belongs_to :plan
  belongs_to :move, optional:true

  has_one_attached :image

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  # def get_icon(move_id)
  #   case move_id
  #     when "walk"
  #       "fab fa-google-wallet"
  #     when "bicycle"
  #       "fas fa-bicycle"
  #     when "car"
  #       "fad fa-car"
  #     when "taxi"
  #       "fad fa-taxi"
  #     when "train"
  #       "fad fa-train"
  #     when "bus"
  #       "fad fa-bus"
  #   end
  # end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
