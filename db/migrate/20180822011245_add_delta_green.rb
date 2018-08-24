class AddDeltaGreen < ActiveRecord::Migration
  def change
    rename_table :characters, :coc_characters
    rename_table :characteristic_sets, :coc_characteristic_sets
    rename_table :skill_sets, :coc_skill_sets
  end
end

