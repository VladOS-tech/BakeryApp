class RequestsController < ApplicationController
  def index
    if params[:bakery_id]
      requests = Request.where(bakery_id: params[:bakery_id])
    else
      requests = Request.all
    end
    render json: requests.as_json(include: { request_items: { include: :product } })
  end

  def show
    request = Request.find(params[:id])
    render json: request
  end

  def create
    request = Request.new(request_params)
    if request.save
      render json: request, status: :created
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def update
    request = Request.find(params[:id])
    if request.update(request_params)
      render json: request
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def destroy
    request = Request.find(params[:id])
    request.destroy
    head :no_content
  end

  private

  def request_params
    params.require(:request).permit(:bakery_id, :request_date)
  end
end
