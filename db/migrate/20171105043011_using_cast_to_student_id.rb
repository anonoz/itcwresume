class UsingCastToStudentId < ActiveRecord::Migration[5.0]
  def change
  	change_column :resumes, :student_id, 'integer USING CAST(student_id AS integer)'
  	change_column :progresses, :student_id, 'integer USING CAST(student_id AS integer)'
  end
end
