class AddPhoneNumberAndEmailToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :phone_number, :string
    add_column :students, :email_address, :string
  end
end
