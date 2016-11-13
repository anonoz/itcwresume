class AddRejectionReasonToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :rejection_reason, :text
  end
end
