class Product < ActiveRecord::Base
  validates :name, presence: true
  validate :positive_price

  def positive_price()
    unless(price.to_f > 0)
      errors.add(:price, "Price must be positive!")
    end
  end
end
