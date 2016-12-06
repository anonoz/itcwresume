class AddDeletedAtToEmployers < ActiveRecord::Migration[5.0]
  def change
    add_column :employers, :deleted_at, :time
  end
end
