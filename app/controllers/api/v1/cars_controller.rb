class Api::V1::CarsController < ApplicationController
  before_action :set_api_v1_car, only: %i[show update destroy]

  # GET /api/v1/cars
  def index
    @api_v1_cars = Api::V1::Car.all

    render json: @api_v1_cars
  end

  # GET /api/v1/cars/1
  def show
    render json: @api_v1_car
  end

  # POST /api/v1/cars
  def create
    @api_v1_car = Api::V1::Car.new(api_v1_car_params)

    if @api_v1_car.save
      render json: @api_v1_car, status: :created, location: @api_v1_car
    else
      render json: @api_v1_car.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cars/1
  def update
    if @api_v1_car.update(api_v1_car_params)
      render json: @api_v1_car
    else
      render json: @api_v1_car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cars/1
  def destroy
    @api_v1_car.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_car
    @api_v1_car = Api::V1::Car.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_car_params
    params.require(:api_v1_car).permit(:name, :description, :photo, :price, :model, :user_id)
  end
end
