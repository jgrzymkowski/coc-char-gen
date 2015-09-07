class AddDeletedAt < ActiveRecord::Migration
  def change
    add_column :characters, :deleted_at, :datetime
    add_column :campaigns, :deleted_at, :datetime
  end
end
