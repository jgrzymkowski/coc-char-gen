class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :text
    add_column :users, :last_name, :text
    remove_column :characters, :player_name
  end
end
