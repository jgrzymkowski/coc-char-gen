class AddDgCharacters < ActiveRecord::Migration
  def change
    create_table :dg_campaigns do |t|
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :dg_characters do |t|
      t.string :investigator_name
      t.string :first_name
      t.string :last_name
      t.string :middle_initial
      t.string :profession
      t.string :employer
      t.string :nationality
      t.string :gender
      t.string :date_of_birth
      t.string :education_and_occupational_history
      t.timestamps
    end
  end
end
