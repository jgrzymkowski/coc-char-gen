class AddRequiredConstraints < ActiveRecord::Migration
  def change
    change_column :characters, :user_id, :integer, default: nil
    change_column :characters, :campaign_id, :integer, default: nil
  end
end
