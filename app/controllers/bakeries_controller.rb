class BakeriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    bakeries = Bakery.all
    render json: bakeries
  end

  def show
    bakery = Bakery.find(params[:id])
    render json: bakery
  end

  def create
    bakery = Bakery.new(bakery_params)
    if bakery.save
      render json: bakery, status: :created
    else
      render json: bakery.errors, status: :unprocessable_entity
    end
  end

  def update
    bakery = Bakery.find(params[:id])
    if bakery.update(bakery_params)
      render json: bakery
    else
      render json: bakery.errors, status: :unprocessable_entity
    end
  end

  def destroy
    bakery = Bakery.find(params[:id])
    bakery.destroy
    head :no_content
  end

  private

  def bakery_params
    params.require(:bakery).permit(:name)
  end
end
