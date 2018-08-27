class AddDgStatistics < ActiveRecord::Migration
  def change
    create_table :dg_statistic_sets do |t|
      t.integer :strength
      t.integer :constitution
      t.integer :dexterity
      t.integer :intelligence
      t.integer :power
      t.integer :charisma
      t.references :character
      t.timestamps
    end
  end
end
