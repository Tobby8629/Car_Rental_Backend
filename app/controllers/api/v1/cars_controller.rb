class Api::V1::CarsController < ApplicationController
  def index
    render json: { cars: Car.all }, status: :ok
  end

  def show
    @car = Car.find(params[:id])
    render json: { car: @car }, status: :ok
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      render json: { success: 'The car has been created successfully.' }, status: :created
    else
      render json: { error: 'There was an error, please try again!' }, status: :internal_server_error
    end
  end

  def delete
    @car = Car.find(params[:id])
    if @car.destroy!
      render json: { success: 'The car has been deleted successfully' }, status: :ok
    else
      render json: { error: 'There was an error, please try again!' }, status: :internal_server_error
    end
  end

  def user_cars
    @cars = User.find(params[:user_id]).cars
    render json: { cars: @cars }, status: :ok
  end

  private

  def car_params
    params.require(:car).permit(:user_id, :model, :make, :picture, :price)
  end

  def authenticate_user!
    return if user_signed_in?

    render json: {
      code: 401,
      message: 'Unauthorized access'
    }, status: :unauthorized
  end
end
