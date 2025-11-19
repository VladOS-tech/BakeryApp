class RequestItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    request_items = RequestItem.all
    render json: request_items
  end

  def show
    request_item = RequestItem.find(params[:id])
    render json: request_item
  end

  def create
    request_item = RequestItem.new(request_item_params)
    if request_item.save
      render json: request_item, status: :created
    else
      render json: request_item.errors, status: :unprocessable_entity
    end
  end

  def update
    request_item = RequestItem.find(params[:id])
    if request_item.update(request_item_params)
      render json: request_item
    else
      render json: request_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    request_item = RequestItem.find(params[:id])
    request_item.destroy
    head :no_content
  end

  private

  def request_item_params
    params.require(:request_item).permit(:request_id, :product_id, :quantity)
  end
end
