class Order < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  validate :positive_quantity

  def positive_quantity()
    unless(quantity.to_i >= 1)
      errors.add(:quantity, "Positive quantity needed!")
    end
  end
end
