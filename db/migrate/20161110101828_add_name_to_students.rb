class AddNameToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :name, :string
  end
end
