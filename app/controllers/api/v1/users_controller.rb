class Api::V1::UsersController < ApplicationController
  def register
    if User.find_by(username: params[:username].downcase)
      render json: { error: 'Username already exists! Please choose another one.' }, status: :not_acceptable
    else
      @user = User.new(username: params[:username].downcase)
      if @user.save
        render json: { user: @user, logged_in: true }, status: :created
      else
        render json: { error: 'There was an error, please try again!' }, status: :internal_server_error
      end
    end
  end

  def login
    @user = User.find_by(username: params[:username].downcase)
    if @user
      render json: { user: @user, logged_in: true }, status: :ok
    else
      render json: { error: 'Username is invalid.' }, status: :not_acceptable
    end
  end
end
