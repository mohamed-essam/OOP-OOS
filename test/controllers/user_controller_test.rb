require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "user_create" do
    post :create, first_name: "Hello", last_name: "Bitch", email: "hib@it.ch", phone: "0123", password: "101023", password_confirmation: "101023", user_name: "hibtich"
    x = JSON.parse(response.body)
    assert(x["status"])
    assert(User.last.first_name == "Hello")
  end

  test "user_auth" do
    post :create, first_name: "Hello", last_name: "Bitch", email: "hib@it.ch", phone: "0123", password: "101023", password_confirmation: "101023", user_name: "hibtich"
    post :auth, user_name: "hibtich", password: "101022"
    assert(JSON.parse(response.body)["status"] == false)
    post :auth, user_name: "hibtich", password: "101023"
    assert(JSON.parse(response.body)["status"])
  end

  test "user_place_order" do
    post :create, first_name: "Hello", last_name: "Bitch", email: "hib@it.ch", phone: "0123", password: "101023", password_confirmation: "101023", user_name: "hibtich"
    Product.new(name: "spray", price: '3.25').save
    post :placeOrder, user_id: User.last.id, user_auth_key: "101023", product_id: Product.last.id, quantity: '5'
    assert(JSON.parse(response.body)["status"])
    assert(Order.last.quantity == 5)
  end

  test "user_list_orders" do
    post :create, first_name: "Bye", last_name: "Mate", email: "ma@it.ch", phone: "0123", password: "123456789", password_confirmation: "123456789", user_name: "thingy"
    Product.new(name: "spray", price: '3.25').save
    post :placeOrder, user_id: User.last.id, user_auth_key: "101023", product_id: Product.last.id, quantity: '10'
    post :create, first_name: "Hello", last_name: "Bitch", email: "hib@it.ch", phone: "0123", password: "101023", password_confirmation: "101023", user_name: "hibtich"
    post :placeOrder, user_id: User.last.id, user_auth_key: "101023", product_id: Product.last.id, quantity: '5'
    post :listOrders, user_id: User.last.id, user_auth_key: "101023"
    #puts(response.body)
  end
end
