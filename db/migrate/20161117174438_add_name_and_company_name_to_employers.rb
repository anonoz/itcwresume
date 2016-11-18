class AddNameAndCompanyNameToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :name, :string
    add_column :employers, :company_name, :string
  end
end
