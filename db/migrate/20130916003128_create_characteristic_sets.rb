class CreateCharacteristicSets < ActiveRecord::Migration
  def change
    create_table :characteristic_sets do |t|
      t.integer :strength
      t.integer :dexterity
      t.integer :intelligence
      t.integer :constitution
      t.integer :appearance
      t.integer :power
      t.integer :size
      t.integer :education

      t.belongs_to :character
      t.timestamps
    end
  end
end
