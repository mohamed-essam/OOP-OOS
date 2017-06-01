class Product < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  has_many :reviews
  validates :name, presence: true
  validate :positive_price

  def positive_price()
    unless(price.to_f > 0)
      errors.add(:price, "Price must be positive!")
    end
  end
end
