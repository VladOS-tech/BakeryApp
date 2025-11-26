class RequestItemsController < ApplicationController
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
      audit!("request_item.create", request_item, {
        bakery_id: request_item.request.bakery_id,
        bakery_name: request_item.request.bakery.name,
        request_id: request_item.request_id,
        product_id: request_item.product_id,
        product_name: request_item.product.name,
        quantity: request_item.quantity
      })
      render json: request_item, status: :created
    else
      render json: request_item.errors, status: :unprocessable_entity
    end
  end

  def update
    request_item = RequestItem.find(params[:id])
    old_quantity = request_item.quantity

    if request_item.update(request_item_params)
      audit!("request_item.update", request_item, {
        bakery_id: request_item.request.bakery_id,
        bakery_name: request_item.request.bakery.name,
        request_id: request_item.request_id,
        product_id: request_item.product_id,
        product_name: request_item.product.name,
        old_quantity: old_quantity,
        new_quantity: request_item.quantity
      })
      render json: request_item
    else
      render json: request_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    request_item = RequestItem.find(params[:id])

    audit!("request_item.destroy", request_item, {
      bakery_id: request_item.request.bakery_id,
      bakery_name: request_item.request.bakery.name,
      request_id: request_item.request_id,
      product_id: request_item.product_id,
      product_name: request_item.product.name,
      quantity: request_item.quantity
    })

    request_item.destroy
    head :no_content
  end

  private

  def request_item_params
    params.require(:request_item).permit(:request_id, :product_id, :quantity)
  end
end
