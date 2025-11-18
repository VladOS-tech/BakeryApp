class PurchasesController < ApplicationController
  def index
    purchases = Purchase.all
    render json: purchases
  end

  def show
    warehouse = Purchase.find(params[:id])
    render json: warehouse
  end

  def create
    warehouse = Purchase.new(warehouse_params)
    if warehouse.save
      render json: warehouse, status: :created
    else
      render json: warehouse.errors, status: :unprocessable_entity
    end
  end

  def update
    warehouse = Purchase.find(params[:id])
    if warehouse.update(warehouse_params)
      render json: warehouse
    else
      render json: warehouse.errors, status: :unprocessable_entity
    end
  end

  def destroy
    warehouse = Purchase.find(params[:id])
    warehouse.destroy
    head :no_content
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:purchase_date)
  end
end
