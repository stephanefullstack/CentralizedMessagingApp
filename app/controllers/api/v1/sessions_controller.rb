class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base)
      render json: { token: token, user: { id: user.id, email: user.email } }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
