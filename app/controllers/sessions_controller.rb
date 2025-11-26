class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    user = User.includes(:bakeries).find_by(phone: params[:phone])
    if user&.authenticate(params[:password])
      token = JwtService.encode({ id: user.id, role: user.role })
      render json: {
        token: token,
        role: user.role,
        id: user.id,
        name: user.name,
        bakeries: user.bakeries.as_json(only: [ :id, :name ]) # ← Главное нововведение
      }
    else
      render json: { error: "Неверный телефон или пароль" }, status: 401
    end
  end
end
