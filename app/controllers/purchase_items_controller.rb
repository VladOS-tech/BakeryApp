class PurchaseItemsController < ApplicationController
  def index
    purchase_items = PurchaseItem.all
    render json: purchase_items
  end

  def show
    purchase_item = PurchaseItem.find(params[:id])
    render json: purchase_item
  end

  def create
    purchase_item = PurchaseItem.new(purchase_item_params)
    if purchase_item.save
      render json: purchase_item, status: :created
    else
      render json: purchase_item.errors, status: :unprocessable_entity
    end
  end

  def update
    purchase_item = PurchaseItem.find(params[:id])
    if purchase_item.update(purchase_item_params)
      render json: purchase_item
    else
      render json: purchase_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    purchase_item = PurchaseItem.find(params[:id])
    purchase_item.destroy
    head :no_content
  end

  private

  def purchase_item_params
    params.require(:purchase_item).permit(:purchase_id, :product_id, :warehouse_id, :quantity, :price)
  end
end
