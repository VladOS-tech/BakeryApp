class AuditLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_boss!  # начальник / админ

  # GET /audit_logs
  # опциональные параметры:
  #   from=2025-11-20
  #   to=2025-11-27
  #   bakery_id=1
  #   user_id=5
  def index
    logs = AuditLog.includes(:user).order(created_at: :desc)

    if params[:from].present?
      from_date = Date.parse(params[:from]) rescue nil
      logs = logs.where("created_at >= ?", from_date.beginning_of_day) if from_date
    end

    if params[:to].present?
      to_date = Date.parse(params[:to]) rescue nil
      logs = logs.where("created_at <= ?", to_date.end_of_day) if to_date
    end

    if params[:user_id].present?
      logs = logs.where(user_id: params[:user_id])
    end

    if params[:bakery_id].present?
      # предполагается, что в data пишешь bakery_id
      logs = logs.where("data ->> 'bakery_id' = ?", params[:bakery_id].to_s)
    end

    render json: logs.as_json(
      only: [ :id, :action, :subject_type, :subject_id, :data, :created_at ],
      include: {
        user: { only: [ :id, :name, :email ] }
      }
    )
  end

  private

  def require_boss!
    unless current_user&.boss? # здесь твоя проверка роли начальника
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
