class AddDeletedAtToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :deleted_at, :time
  end
end
