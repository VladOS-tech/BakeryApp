class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  before_action :authenticate_user!

  attr_reader :current_user

  private

  def authenticate_user!
    header = request.headers["Authorization"] || ""
    token = header.split(" ").last
    decoded = JwtService.decode(token)
    if decoded && (user = User.find_by(id: decoded[:id]))
      @current_user = user
    else
      render json: { error: "Не авторизован" }, status: 401
    end
  end

  # Changes to the importmap will invalidate the etag for HTML responses
end
