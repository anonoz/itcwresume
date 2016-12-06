class AddCompanyIdToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :company_id, :integer
    add_index :employers, :company_id
  end
end
