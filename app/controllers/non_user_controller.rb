class NonUserController < ApplicationController

  # Lists categories' names
  def listCats
    ret = []
    Rails.logger.info("A")
    Category.find_each do |c|
      Rails.logger.info("B")
      ret << {id: c.id, name: c.name}
    end
    Rails.logger.info("C")
    render json: ret
  end

  # Lists products in a given category
  # params => cat : ID of category
  def listCatProds
    cat = params[:cat]
    ret = []
    Product.where(category_id: cat).find_each do |p|
      ret << {id: p.id, category_id: p.category_id, name: p.name, price: p.price}
    end
    render json: ret
  end
end
