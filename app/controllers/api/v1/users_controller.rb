module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.create(user_params)
        if user.save
          render json: UserRepresenter.new(user).as_json, status: :created
        else
          render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
        end
      end
      def index
        users = User.all
        render json: users
      end

      private

      def user_params
        params.require(:user).permit(:username)
      end
    end
  end
end