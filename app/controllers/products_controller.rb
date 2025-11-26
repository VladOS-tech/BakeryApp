class ProductsController < ApplicationController
  def index
    products = Product.active
    render json: products
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.request_items.exists?
      product.update(active: false)
      head :no_content
    else
      product.destroy
      head :no_content
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :warehouse_id)
  end
end
