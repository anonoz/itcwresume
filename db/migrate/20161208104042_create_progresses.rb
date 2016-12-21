class CreateProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :progresses do |t|
      t.integer :student_id
      t.integer :company_id
      t.integer :progress, default: 0
      t.time :deleted_at
    end

    add_index :progresses, :company_id
    add_index :progresses, :student_id
  end
end
