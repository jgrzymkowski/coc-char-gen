class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string  :investigator_name
      t.string  :first_name
      t.string  :last_name
      t.string  :occupation
      t.string  :degrees
      t.string  :birthplace
      t.string  :gender
      t.integer :age
      t.timestamps
    end
  end
end
