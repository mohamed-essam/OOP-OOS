class UserController < ApplicationController
  def create()
    u = User.new(user_name: params[:user_name],first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone], password: params[:password], password_confirmation: params[:password_confirmation])
    status = u.save
    errors = u.errors
    render json: {status: status, reason: errors.full_messages, data: ""}
  end

  def auth()
    u = User.find_by(user_name: params[:user_name])
    if(u == nil)
      render json: {status: false, uid: -1, reason: "['Wrong username']", data: ""}
    end
    res = u.authenticate(params[:password])
    if(res)
      render json: {status: true, uid: res.id, reason: "", data: ""}
      return
    end
    render json: {status: false, uid: -1, reason: "[Wrong password]", data: ""}
  end

  def listOrders()
    if(!User.find(params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    uid = params[:user_id]
    ret = []
    Order.where(user_id: uid).find_each do |order|
      ret << {id: order.id, product_id: order.product_id, user_id: order.user_id, quantity: order.quantity, price_per_unit: order.price_per_unit, order_status: order.order_status}
    end
    render json: {data: ret.to_json, status: true, reason: '[]'}
  end

  def placeOrder()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    o = Order.new(product_id: params[:product_id], user_id: params[:user_id], price_per_unit: Product.find(params[:product_id]).price, quantity: params[:quantity], order_status: '0')
    status = o.save
    render json: {status: status, reason: o.errors.full_messages, data: ""}
  end

  def editOrder()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    o = Order.find_by(id: params[:order_id])
    if(o == nil)
      render json: {status: false, reason: "['Order not found!']", data: ""}
      return
    end
    if(o.order_status != 0)
      render json: {status: false, reason: "['Order has started processing']", data: ""}
      return
    end
    status = o.update(order_status: params[:quantity])
    render json: {status: status, reason: o.errors.full_messages, data: ""}
  end

  def deleteOrder()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    o = Order.find_by(id: params[:order_id])
    if(o == nil)
      render json: {status: false, reason: "['Order not found!']", data: ""}
      return
    end
    if(o.order_status != 0)
      render json: {status: false, reason: "['Order has started processing']", data: ""}
      return
    end
    if(o.user_id != params[:user_id])
      render json: {status: false, reason: "['Wrong user!']", data: ""}
      return
    end
    status = o.destroy
    render json: {status: status, reason: o.errors.full_messages, data: ""}
  end

  def writeReview()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    r = Review.new(user_id: params[:user_id], product_id: params[:product_id], title: params[:title], body: params[:body], rating: params[:rating])
    status = r.save
    render json: {status: status, reason: r.errors.full_messages, data: ""}
  end

  def removeReview()
    if(!User.find_by(id: params[:user_id]).authenticate(params[:password]))
      render json: {status: false, reason: "['Authentication failed!']", data: ""}
      return
    end
    r = Review.find_by(id: params[:id])
    if(r.user_id != params[:user_id])
      render json: {status: false, reason: "['Wrong user!']", data: ""}
      return
    end
    status = r.destroy
    render json: {status: status, reason: r.errors.full_messages, data: ""}
  end
end
