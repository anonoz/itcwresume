class AddFileColumnToResumes < ActiveRecord::Migration[5.0]
  def up
    add_attachment :resumes, :file
  end

  def down
    remove_attachment :resumes, :file
  end
end
