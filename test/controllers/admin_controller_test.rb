require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    if(Admin.find_by(user_name: 'Jake_M~') == nil)
      Admin.new({user_name: 'Jake_M~', email: 'jake@my.com', auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!'}).save
    end
    if(Order.find_by(id: 1) == nil)
      puts(User.new(first_name: "Ali", last_name: "Essam", user_name: "aeahmg", phone: "01203213124", email: "ali.essam@my.com", password: "abcdefghijklmnopqrstuvwxyz", password_confirmation: "abcdefghijklmnopqrstuvwxyz").save)
      uid1 = User.last.id
      puts(User.new(first_name: "Ali", last_name: "Essam", user_name: "aeahmg", phone: "01203213124", email: "ali.essam@my.com", password: "abcdefghijklmnopqrstuvwxyz", password_confirmation: "abcdefghijklmnopqrstuvwxyz").save)
      uid2 = User.last.id
      puts(Product.new(name: "Amazing product", price: '5.5').save)
      pid = Product.last.id
      Order.new(product_id: pid, user_id: uid1, price_per_unit: 3, quantity: 2, order_status: 0).save
      Order.new(product_id: pid, user_id: uid1, price_per_unit: 4, quantity: 1, order_status: 0).save
      Order.new(product_id: pid, user_id: uid2, price_per_unit: 5, quantity: 23, order_status: 0).save
      Order.new(product_id: pid, user_id: uid2, price_per_unit: 6, quantity: 12, order_status: 0).save
      Order.new(product_id: pid, user_id: uid2, price_per_unit: 8, quantity: 9, order_status: 0).save
    end
  end

  test "admin_add_cat" do
    post :addCat, admin_id: 'Jake_M~' , admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'FF'
    c = Category.last
    assert(c.name == 'FF')
  end

  test "admin_edit_cat" do
    post :addCat, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'FF'
    post :editCat, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'DD', id: Category.last.id
    assert(Category.last.name == 'DD')
  end

  test "admin_delete_cat" do
    post :addCat, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'AA'
    c = Category.last.id
    post :deleteCat, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', id: Category.last
    assert(Category.find_by(id: c) == nil)
  end

  test "admin_add_prod" do
    post :addProd, admin_id: 'Jake_M~' , admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'FF', price: '5.5'
    assert(Product.last.name == 'FF' && Product.last.price == 5.5)
  end

  test "admin_edit_prod" do
    post :addProd, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'FF', price: '3.3'
    post :editProd, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'DD', price: '5.5', id: Product.last.id
    assert(Product.last.name == 'DD' && Product.last.price == 5.5)
  end

  test "admin_delete_prod" do
    post :addProd, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', name: 'AA', price: '7.7'
    c = Product.last.id
    post :deleteProd, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', id: c
    assert(Product.find_by(id: c) == nil)
  end

  test "admin_list_orders" do
    post :listOrders, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!'
    js = JSON.parse(response.body)
  end

  test "admin_edit_order" do
    Order.new(product_id: 1, user_id: 2, price_per_unit: 8, quantity: 9, order_status: 0).save
    post :orderStatusEdit, admin_id: 'Jake_M~', admin_auth_key: 'M~,AAS-+OIumKGdP4~U3qbS+rN[-09ft/{:1@G8acj3+^HS0|(Qbiis{3+=yaX#!', id: Order.last.id, status: 1
    assert(Order.last.order_status == 1)
  end
end
