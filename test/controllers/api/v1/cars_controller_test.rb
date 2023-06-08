require "test_helper"

class Api::V1::CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_car = api_v1_cars(:one)
  end

  test "should get index" do
    get api_v1_cars_url, as: :json
    assert_response :success
  end

  test "should create api_v1_car" do
    assert_difference("Api::V1::Car.count") do
      post api_v1_cars_url, params: { api_v1_car: { description: @api_v1_car.description, model: @api_v1_car.model, name: @api_v1_car.name, photo: @api_v1_car.photo, price: @api_v1_car.price, user_id: @api_v1_car.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_car" do
    get api_v1_car_url(@api_v1_car), as: :json
    assert_response :success
  end

  test "should update api_v1_car" do
    patch api_v1_car_url(@api_v1_car), params: { api_v1_car: { description: @api_v1_car.description, model: @api_v1_car.model, name: @api_v1_car.name, photo: @api_v1_car.photo, price: @api_v1_car.price, user_id: @api_v1_car.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_car" do
    assert_difference("Api::V1::Car.count", -1) do
      delete api_v1_car_url(@api_v1_car), as: :json
    end

    assert_response :no_content
  end
end
