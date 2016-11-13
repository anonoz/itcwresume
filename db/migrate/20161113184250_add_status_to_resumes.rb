class AddStatusToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :status, :integer, default: 0
  end
end
