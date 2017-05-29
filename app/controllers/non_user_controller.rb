class NonUserController < ApplicationController

  # Lists categories' names
  def listCats
    ret = []
    Category.find_each do |c|
      ret << {id: c.id, name: c.name}
    end
    render json: ret
  end

  # Lists products in a given category
  # params => cat : ID of category
  def listCatProds
    cat = params[:cat_id]
    ret = []
    Product.where(category_id: cat).find_each do |p|
      ret << {id: p.id, category_id: p.category_id, name: p.name, price: p.price, picture_list: p.picture_list}
    end
    render json: ret
  end
end
