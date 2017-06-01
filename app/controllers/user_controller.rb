class UserController < ApplicationController
  def create()
    u = User.new(user_name: params[:user_name],first_name: params[:first_name]
    , last_name: params[:last_name], email: params[:email]
    , phone: params[:phone], password: params[:password]
    , password_confirmation: params[:password_confirmation])
    render json: {status: u.save}
  end

  def auth()
    u = User.find_by(user_name: params[:user_name])
    res = u.authenticate(params[:password])
    if(res)
      render json: {status: true, uid: res.id}
      return
    end
    render json: {status: false, uid: -1}
  end

  def listOrders()
    if(!User.find(params[:user_id]).authenticate(params[:password]))
      render json: {status: false}
      return
    end
    uid = params[:user_id]
    ret = []
    Order.where(user_id: uid).find_each do |order|
      ret << {id: order.id, product_id: order.product_id, user_id: order.user_id, quantity: order.quantity, price_per_unit: order.price_per_unit, order_status: order.order_status}
    end
    render json: ret
  end

  def placeOrder()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false}
      return
    end
    o = Order.new(product_id: params[:product_id], user_id: params[:user_id], price_per_unit: Product.find(params[:product_id]).price, quantity: params[:quantity], order_status: '0')
    render json: {status: o.save}
  end

  def writeReview()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false}
      return
    end
    r = Review.new(user_id: params[:user_id], product_id: params[:product_id], title: params[:title], body: params[:body], rating: params[:rating])
    render json: {status: r.save}
  end

  def removeReview()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false}
      return
    end
    r = Review.find_by(id: params[:id])
    if(r.user_id != params[:user_id])
      render json: {status: false}
      return
    end
    render json: {status: r.destroy}
  end
end
