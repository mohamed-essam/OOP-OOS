require 'test_helper'

class NonUserControllerTest < ActionController::TestCase
  setup do
    Category.new({name: "A"}).save
    Category.new({name: "B"}).save
  end

  test "should get listCats" do
    post :listCats
    #puts JSON.parse(response.body)
  end

  test "should get listCatProds" do
    post :listCatProds, id: Category.last.id
    #puts JSON.parse(response.body)
  end

end
