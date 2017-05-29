class DebugController < ApplicationController

  def listOrders()
    ret = []
    Order.find_each do |order|
      ret << {id: order.id, product_id: order.product_id, user_id: order.user_id, quantity: order.quantity, price_per_unit: order.price_per_unit}
    end
    render json: JSON.pretty_generate(ret)
  end

  def listUsers()
    ret = []
    User.find_each do |user|
      ret << {id: user.id, first_name: user.first_name, last_name: user.last_name, user_name: user.user_name, email: user.email, phone: user.phone}
    end
    render json: JSON.pretty_generate(ret)
  end

  def listAdmins()
    ret = []
    Admin.find_each do |admin|
      ret << {id: admin.id, user_name: admin.user_name, auth_key: admin.auth_key}
    end
    render json: JSON.pretty_generate(ret)
  end

  def listProducts()
    ret = []
    Product.find_each do |p|
      ret << {id: p.id, category_id: p.category_id, name: p.name, price: p.price, picture_list: p.picture_list}
    end
    render json: JSON.pretty_generate(ret)
  end

  def listCategories()
    ret = []
    Category.find_each do |cat|
      ret << {id: cat.id, name: cat.name}
    end
    render json: JSON.pretty_generate(ret)
  end
end
