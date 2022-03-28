class Plan < ApplicationRecord

  has_many :contents
  belongs_to :user
  belongs_to :comment
  belongs_to :favorite

end
