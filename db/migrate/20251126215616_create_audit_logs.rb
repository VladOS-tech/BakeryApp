class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :subject_type
      t.integer :subject_id
      t.jsonb :data

      t.timestamps
    end
  end
end
