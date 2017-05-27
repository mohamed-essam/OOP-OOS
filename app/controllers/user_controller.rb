class UserController < ApplicationController
  def create()
    u = User.new
    u.user_name = params[:user_name]
    u.first_name = params[:first_name]
    u.last_name = params[:last_name]
    u.email = params[:email]
    u.phone = params[:phone]
    u.password = params[:password]
    u.password_confirmation = params[:password_confirmation]
    render json: {status: u.save}
  end

  def auth()
    u = User.find_by(user_name: params[:user_name])
    res = u.authenticate(params[:password])
    if(res)
      render json: {status: true, uid: res.id}
      return
    end
    render json: {status: false}
  end

  def listOrders()
    if(!User.find(params[:user_id]).authenticate(params[:user_auth_key]))
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
    if(!User.find_by(id: params[:user_id]).authenticate(params[:user_auth_key]))
      render json: {status: false}
      return
    end
    o = Order.new
    o.product_id = params[:product_id]
    o.user_id = params[:user_id]
    o.price_per_unit = Product.find(params[:product_id]).price
    o.quantity = params[:quantity]
    o.order_status = '0'
    render json: {status: o.save}
  end
end
