class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes do |t|
      t.integer :student_id
      t.integer :nationality
      t.integer :job_type

      t.timestamps
    end
  end
end
