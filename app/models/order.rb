class Order < ActiveRecord::Base
  validate :user_id_exists, :product_id_exists, :positive_quantity

  def positive_quantity()
    unless(quantity.to_i >= 1)
      errors.add(:quantity, "Positive quantity needed!")
    end
  end

  def user_id_exists()
    if(User.find_by(id: user_id) == nil)
      errors.add(:user_id, "User doesn't exist!")
    end
  end

  def product_id_exists()
    if(Product.find_by(id: product_id) == nil)
      errors.add(:product_id, "Product doesn't exist")
    end
  end
end
