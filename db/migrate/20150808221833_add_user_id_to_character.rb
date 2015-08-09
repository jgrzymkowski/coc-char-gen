class AddUserIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :user_id, :integer, index: true
    add_column :characters, :campaign_id, :integer, index: true
  end
end
