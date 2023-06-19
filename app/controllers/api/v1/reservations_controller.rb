module Api
  module V1
    class ReservationsController < ApplicationController
      #before_action :authenticate_request!, only: %i[create update destroy]
      before_action :set_reservation, only: %i[update show destroy]
      # GET /reservations
      def index
        @reservations = Reservation.all
        @reservation_data = @reservations.map do |reservation|
          {
            image: rails_blob_url(reservation.car.photo),
            id: reservation.id,
            city: reservation.city,
            pick_up: reservation.pick_up,
            return_date: reservation.return_date,
            car: Car.find(reservation.car_id).name
          }
        end
        render json: @reservation_data
        # render json: ReservationsRepresenter.new(@reservations).as_json
      end

      # POST /reservations
      def create
        @User = User.find(params[:reservation][:user_id])
        @reservation = @User.reservations.new(reservation_params)
        if @reservation.save
          render json: ReservationRepresenter.new(@reservation).as_json, status: :created
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end
      # GET /reservations/:id
      def show
        render json: ReservationRepresenter.new(@reservation).as_json
      end
      # PUT /reservations/:id
      def update
        @reservation.update(reservation_params)
        if @reservation.save
          render json: ReservationRepresenter.new(@reservation).as_json, status: :created
        else
          render json: @reservation.errors, status: :unprocessable_entity
        end
      end
      # DELETE /reservations/:id
      def destroy
        @reservation.destroy
        head :no_content
      end
      private
      def reservation_params
        params.require(:reservation).permit(:city, :pick_up, :return_date, :car_id, :user_id)
      end
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end
    end
  end
end