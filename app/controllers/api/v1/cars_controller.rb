module Api
  module V1
    class CarsController < ApplicationController
      # before_action :authenticate_request!, only: %i[create update destroy]
      before_action :set_car, only: %i[update show destroy]
      # GET /cars
      def index
        @cars = Car.all
        response.headers['Cache-Control'] = 'public, max-age=3600'
        fresh_when(@cars, public: true)
        @car_data = @cars.map do |car|
          {
            id: car.id,
            name: car.name,
            description: car.description,
            photo: rails_blob_url(car.photo),
            price: car.price,
            model: car.model,
            user_id: car.user_id,
            username: car.user.username
          }
        end
        render json: @car_data

        # render json: CarsRepresenter.new(@cars).as_json
      end

      def cars
        @cars = Car.where(user_id: params[:id])
        response.headers['Cache-Control'] = 'public, max-age=3600'
        fresh_when(@cars, public: true)
        @car_data = @cars.map do |car|
          {
            id: car.id,
            name: car.name,
            description: car.description,
            photo: rails_blob_url(car.photo),
            price: car.price,
            model: car.model,
            user_id: car.user_id,
            username: car.user.username
          }
        end
        render json: @car_data

        # render json: CarsRepresenter.new(@cars).as_json
      end

      # POST /car
      def create
        @user = User.find(params[:car][:user_id])
        @car = @user.cars.create(car_params)
        @car.photo.attach(params[:car][:photo]) if params[:car][:photo]
        if @car.save
          render json: CarRepresenter.new(@car).as_json, status: :created
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      # GET /cars/:id
      def show
        @car = Car.find(params[:id])
        response.headers['Cache-Control'] = 'public, max-age=3600'
        fresh_when(@car, public: true)
        @cardata = {
          id: @car.id,
          name: @car.name,
          description: @car.description,
          photo: rails_blob_url(@car.photo),
          price: @car.price,
          model: @car.model,
          user_id: @car.user_id,
          username: @car.user.username
        }
        render json: @cardata
        # render json: CarRepresenter.new(@car).as_json
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

      # DELETE /cars/:id
      def destroy
        @car.destroy
        head :no_content
      end

      private

      def car_params
        params.require(:car).permit(:name, :description, :price, :model, :user_id, :photo)
      end

      def set_car
        @car = Car.find(params[:id])
      end
    end
  end
end
