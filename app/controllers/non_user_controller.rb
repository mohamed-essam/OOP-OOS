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

  # Returns all reviews a product has
  def getProductReviews
    r = Product.find_by(id: params[:product_id]).reviews
    ret = []
    r.find_each do |rev|
      ret << {user_id: r.user_id, product_id: r.product_id, title: r.title, body: r.body, rating: r.rating}
    end
    render json: ret
  end

  # Returns all user public data given the id
  # params => user_id : id of user to get their public data
  def getUserPublicData
    u = User.find_by(id: params[:user_id])
    ret = []
    u.find_each do |user|
      ret << {id: user.id, first_name: user.first_name, last_name: user.last_name}
    end
  end

  # Returns all user reviews given the id
  # params => user_id : id of user to get their reviews
  def getUserReviews()
    r = User.find_by(id: params[:user_id]).reviews
    ret = []
    r.find_each do |rev|
      ret << {user_id: r.user_id, product_id: r.product_id, title: r.title, body: r.body}
    end
    render json: ret
  end

end
