class DebugController < ApplicationController

  def listOrders()
    ret = []
    Order.find_each do |order|
      ret << order
    end
    render json: JSON.pretty_generate(ret)
  end

  def listUsers()
    ret = []
    User.find_each do |user|
      ret << user
    end
    render json: JSON.pretty_generate(ret)
  end

  def listAdmins()
    ret = []
    Admin.find_each do |admin|
      ret << admin
    end
    render json: JSON.pretty_generate(ret)
  end

  def listProducts()
    ret = []
    Product.find_each do |prod|
      ret << prod
    end
    render json: JSON.pretty_generate(ret)
  end

  def listCategories()
    ret = []
    Category.find_each do |cat|
      ret << cat
    end
    render json: JSON.pretty_generate(ret)
  end
end
