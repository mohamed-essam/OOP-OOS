class AdminController < ApplicationController

  # Verify admin authenticity
  def authenticateAdmin(admin_id, auth_key)
    admin = Admin.find_by(user_name: admin_id)
    if(!admin)
      return false
    end
    return admin.auth_key == auth_key
  end

  def auth()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    render json: {status: true}
  end

  # Add category to database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           name : Name of new category
  def addCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    c = Category.new
    c.name = params[:name]
    render json: {status: c.save}
  end

  # Edit category name in database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of category to be edited
  #           name : New name of category
  def editCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    c = Category.find(params[:id])
    c.update(name: params[:name])
    render json: {status: true}
  end

  # Delete category from database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of category to be deleted
  def deleteCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    c = Category.find(params[:id])
    c.destroy
    render json: {status: true}
  end

  # Add product to database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           name : Name/Title of product
  #           price : Price of product per unit
  #           cat_id : ID of category to be assigned to the product
  def addProd()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    p = Product.new
    p.name = params[:name]
    p.price = params[:price].to_f
    p.category_id = params[:cat_id]
    render json: {status: p.save}
  end

  # Edits product int the database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of product to be edited
  #           name : Name/Title of product
  #           price : Price of product per unit
  #           cat_id : ID of category to be assigned to the product
  def editProd()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    p = Product.find(params[:id])
    p.update(name: params[:name], price: params[:price].to_f, category_id: params[:cat_id])
    render json: {status: true}
  end

  # Deletes product from database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of product to be deleted
  def deleteProd()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    p = Product.find(params[:id])
    p.destroy
    render json: {status: true}
  end

  # Lists all orders made by any user
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  def listOrders()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    ret = []
    Order.find_each do |order|
      ret << {id: order.id, product_id: order.product_id, user_id: order.user_id, quantity: order.quantity, price_per_unit: order.price_per_unit}
    end
    render json: ret
  end

  # Edit order status between 0: ordered, 1: delivering, 2: delivered
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of order to be edited
  #           status : New order status
  def orderStatusEdit()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed"}
      return
    end
    o = Order.find(params[:id])
    render json: {status: o.update(order_status: params[:status])}
  end
end
