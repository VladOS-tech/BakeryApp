class AuditLog < ApplicationRecord
  belongs_to :user

  validates :action, presence: true

  validates :subject_type, :subject_id, presence: true
end
