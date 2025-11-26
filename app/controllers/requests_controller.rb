class RequestsController < ApplicationController
  def index
    if params[:date]
      @requests = Request.where(request_date: params[:date]).includes(request_items: :product).all
    else
      @requests = Request.all.includes(request_items: :product)
    end
    render json: @requests.as_json(
      include: {
        request_items: {
          include: {
            product: {
              include: :warehouse
            }
          }
        },
        bakery: {}
      }
    )
  end

  def show
    request = Request.find(params[:id])
    render json: request
  end

  def create
    request = Request.new(request_params)

    if request.save
      audit!("request.create", request, {
        bakery_id: request.bakery_id,
        request_date: request.request_date
      })
      render json: request, status: :created
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def update
    request = Request.find(params[:id])
    old_attrs = request.attributes.slice("bakery_id", "request_date", "user_id")

    if request.update(request_params)
      audit!("request.update", request, {
        old: old_attrs,
        new: request.attributes.slice("bakery_id", "request_date", "user_id")
      })
      render json: request
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def destroy
    request = Request.find(params[:id])

    audit!("request.destroy", request, {
      bakery_id: request.bakery_id,
      request_date: request.request_date,
      user_id: request.user_id
    })

    request.destroy
    head :no_content
  end

  private

  def request_params
    params.require(:request).permit(:user_id, :bakery_id, :request_date)
  end
end
