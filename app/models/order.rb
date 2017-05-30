class Order < ActiveRecord::Base
  belongs_to :user
  validate :user_id_exists, :product_id_exists, :positive_quantity

  def positive_quantity()
    unless(quantity.to_i >= 1)
      errors.add(:quantity, "Positive quantity needed!")
    end
  end

  def product_id_exists()
    if(Product.find_by(id: product_id) == nil)
      errors.add(:product_id, "Product doesn't exist")
    end
  end
end
