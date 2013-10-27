class AddWeaponsToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :weapon_ids, :string
  end
end
