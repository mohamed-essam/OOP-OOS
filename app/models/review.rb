class Review < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :product, dependent: :destroy

  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 256}
end
