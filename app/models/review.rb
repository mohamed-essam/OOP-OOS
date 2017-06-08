class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 256}
end
