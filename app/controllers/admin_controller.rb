class AdminController < ApplicationController

  # Verify admin authenticity
  def authenticateAdmin(admin_id, auth_key)
    admin = Admin.find_by(user_name: admin_id)
    if(!admin)
      return false
    end
    return admin.auth_key == auth_key
  end

  # Endpoint for admin verification
  def auth()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    render json: {status: true, reason: "", data: ""}
  end

  # Add category to database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           name : Name of new category
  def addCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    c = Category.new(name: params[:name])
    status = c.save
    error = ""
    if(c.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Edit category name in database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of category to be edited
  #           name : New name of category
  def editCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    c = Category.find(params[:id])
    status = c.update(name: params[:name])
    error = ""
    if(c.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Delete category from database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of category to be deleted
  def deleteCat()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    c = Category.find(params[:id])
    status = c.destroy
    error = ""
    if(c.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Add product to database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           name : Name/Title of product
  #           price : Price of product per unit
  #           cat_id : ID of category to be assigned to the product
  def addProd()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    p = Product.new(name: params[:name], price: params[:price].to_f, category_id: params[:cat_id], picture_list: '[]')
    status = p.save
    error = ""
    if(p.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
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
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    p = Product.find(params[:id])
    status = p.update(name: params[:name], price: params[:price].to_f, category_id: params[:cat_id])
    error = ""
    if(p.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Deletes product from database
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : databse ID of product to be deleted
  def deleteProd()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    p = Product.find(params[:id])
    status = p.destroy
    error = ""
    if(p.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Lists all orders made by any user
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  def listOrders()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    ret = []
    Order.find_each do |order|
      ret << {id: order.id, product_id: order.product_id, user_id: order.user_id, quantity: order.quantity, price_per_unit: order.price_per_unit}
    end
    render json: {data: ret.to_json, reason: '', status: true}
  end

  # Edit order status between 0: ordered, 1: delivering, 2: delivered
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : database ID of order to be edited
  #           status : New order status
  def orderStatusEdit()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    o = Order.find(params[:id])
    status = o.update(order_status: params[:status])
    render json: {status: status, data: "", reason: ''}
  end

  # Adds a picture to a product
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : database ID of product to be edited
  #           link : URL to picture to be added
  def addPictureToProduct()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    o = Product.find(params[:id])
    pic_list = JSON.parse(o.picture_list)
    pic_list << params[:link]
    status = o.update(picture_list: pic_list.to_json)
    error = ""
    if(o.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end

  # Removes a picture from a product
  # params => admin_id : user name of admin performing the operation
  #           admin_auth_key : Authentication key of that admin
  #           id : database ID of product to be edited
  #           index : index of picture in list
  def deletePictureFromProduct()
    if(!authenticateAdmin(params[:admin_id], params[:admin_auth_key]))
      render json: {status: false, reason: "Authentication Failed", data: ""}
      return
    end
    o = Product.find(params[:id])
    pic_list = JSON.parse(o.picture_list)
    if(params[:index].to_i > pic_list.length)
      render json: {status: false, reason: "Index out of range", data: ""}
      return
    end
    pic_list.delete(params[:index])
    status = o.update(picture_list: pic_list.to_json)
    error = ""
    if(o.errors.full_messages.count > 0)
      error = c.errors.full_messages[0]
    end
    render json: {status: status, reason: error, data: ""}
  end
end
