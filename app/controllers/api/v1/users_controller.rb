class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user
      token = jwt_encode({ user_id: @user.id })
      render json: { token:, user: @user.username }
    else
      render json: { error: 'Invalid username' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
