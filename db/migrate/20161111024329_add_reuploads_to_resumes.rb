class AddReuploadsToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :reuploads, :integer
  end
end
