class Comment < ApplicationRecord

  has_many :plans
  belongs_to :user

end
