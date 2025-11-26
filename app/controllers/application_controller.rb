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

  def audit!(action, subject, data = {})
    return unless current_user

    AuditLog.create!(
      user: current_user,
      action: action,
      subject_type: subject.class.name,
      subject_id: subject.id,
      data: data
    )
  end

  # Changes to the importmap will invalidate the etag for HTML responses
end
