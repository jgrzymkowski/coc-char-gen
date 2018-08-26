class AddDgCharacters < ActiveRecord::Migration
  def change
    create_table :dg_campaigns do |t|
      t.string :name
      t.datetime :deleted_at
      t.integer :owner_id
      t.timestamps
    end

    add_foreign_key :dg_campaigns, :users, column: :owner_id

    create_table :dg_characters do |t|
      t.string :first_name
      t.string :last_name
      t.string :alias
      t.string :profession
      t.string :employer
      t.string :nationality
      t.string :gender
      t.date :date_of_birth
      t.string :education_and_occupational_history
      t.references :user, index: true
      t.references :campaign, index: true
      t.timestamps
    end
  end
end
