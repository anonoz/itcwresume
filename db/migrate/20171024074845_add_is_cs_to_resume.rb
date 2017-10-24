class AddIsCsToResume < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :isCS, :boolean
  end
end
