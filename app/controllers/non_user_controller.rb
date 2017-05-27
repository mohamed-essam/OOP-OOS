class NonUserController < ApplicationController

  # Lists categories' names
  def listCats
    ret = {}
    Category.find_each do |c|
      ret[c.id] = {name: c.name}
    end
    render json: ret
  end

  # Lists products in a given category
  # params => cat : ID of category
  def listCatProds
    cat = params[:cat]
    ret = {}
    Product.where(category_id: cat).find_each do |p|
      ret[p.id] = {category_id: p.category_id, name: p.name, price: p.price}
    end
    render json: ret
  end
end
