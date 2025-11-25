class UsersController < ApplicationController
  # Возможно, потребуется before_action для аутентификации и авторизации
  skip_before_action :verify_authenticity_token


  def index
    users = User.includes(:bakeries).all
    render json: users.as_json(include: :bakeries)
  end

  def show
    user = User.includes(:bakeries).find(params[:id])
    render json: user.as_json(include: :bakeries)
  end

  def create
    user = User.new(user_params)
    if user.save
      if params[:bakery_ids].present?
        params[:bakery_ids].each do |bid|
          BakeryUser.create(user: user, bakery_id: bid)
        end
      end
      render json: user.as_json(include: :bakeries), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      if params[:bakery_ids].present?
        user.bakery_users.destroy_all
        params[:bakery_ids].each do |bid|
          BakeryUser.create(user: user, bakery_id: bid)
        end
      end
      render json: user.as_json(include: :bakeries)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :password, :role)
  end
end
