class Product < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validate :positive_price

  def positive_price()
    unless(price.to_f > 0)
      errors.add(:price, "Price must be positive!")
    end
  end
end
