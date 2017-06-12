class NonUserController < ApplicationController

  # Lists categories' names
  def listCats
    ret = []
    Category.find_each do |c|
      ret << {id: c.id, name: c.name}
    end
    render json: {data: ret.to_json, status: true, reason: ''}
  end

  # Lists products in a given category
  # params => cat : ID of category
  def listCatProds
    if(Category.find_by(id: params[:cat_id]) == nil)
      render json: {data: "", status: false, reason: "Category not found!"}
      return
    end
    cat = params[:cat_id]
    ret = []
    Product.where(category_id: cat).find_each do |p|
      ret << {id: p.id, category_id: p.category_id, name: p.name, price: p.price, picture_list: p.picture_list, desc: p.desc}
    end
    if(ret.size == 0)
      render json: {data: "", status: false, reason: "Category empty!"}
      return
    end
    render json: {data: ret.to_json, status: true, reason: ''}
  end

  # Returns all reviews a product has
  # params => product_id: id of product to get the reviews for
  def getProductReviews
    r = Product.find_by(id: params[:product_id]).reviews
    if(r == nil)
      render json: {data: "", status: false, reason: "Product not found!"}
      return
    end
    ret = []
    r.find_each do |rev|
      ret << {user_id: rev.user_id, product_id: rev.product_id, title: rev.title, body: rev.body, rating: rev.rating}
    end
    render json: {data: ret.to_json, status: false, reason: ""}
  end

  # Returns all user public data given the id
  # params => user_id : id of user to get their public data
  def getUserPublicData
    u = User.find_by(id: params[:user_id])
    if(u == nil)
      render json: {status: false, data: "", reason: "User not found"}
      return
    end
    ret = []
    u.find_each do |user|
      ret << {id: user.id, first_name: user.first_name, last_name: user.last_name}
    end
    render json: {status: true, data: ret.to_json, reason: ""}
  end

  # Returns all user reviews given the id
  # params => user_id : id of user to get their reviews
  def getUserReviews()
    r = User.find_by(id: params[:user_id]).reviews
    if(r == nil)
      render json: {status: false, data: "", reason: "User not found"}
      return
    end
    ret = []
    r.find_each do |rev|
      ret << {user_id: rev.user_id, product_id: rev.product_id, title: rev.title, body: rev.body, rating: rev.rating}
    end
    render json: {status: true, data: ret.to_json, reason: ""}
  end
end
