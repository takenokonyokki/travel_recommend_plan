class Comment < ApplicationRecord

  has_many :plans
  belongs_to :user

  validates :comment, presence: true

end
