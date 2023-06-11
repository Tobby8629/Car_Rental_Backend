class Api::V1::CarsController < ApplicationController
  def index
    @cars = Car.all
    render json: CarsRepresenter.new(@cars).as_json, status: :ok
  end

  def show
    @car = Car.find(params[:id])
    render json: CarRepresenter.new(@car).as_json, status: :ok
  end

  def create
    @car = Car.new(car_params.merge(user: @current_user))
    if @car.save
      render json: CarRepresenter.new(@car).as_json, status: :created
    else
      render json: { error: 'There was an error, please try again!' }, status: :internal_server_error
    end
  end

  # PUT /cars/:id
  def update
    @car.update(car_params)
    if @car.save
      render json: CarRepresenter.new(@car).as_json, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def destroy
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
    params.require(:car).permit(:name, :description, :photo, :price, :model)
  end

end
