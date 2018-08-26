class AddDeltaGreen < ActiveRecord::Migration
  def change
    rename_table :characters, :coc_characters
    rename_table :characteristic_sets, :coc_characteristic_sets
    rename_table :skill_sets, :coc_skill_sets
    rename_table :campaigns, :coc_campaigns

    add_column :coc_campaigns, :owner_id, :integer
    add_foreign_key :coc_campaigns, :users, column: :owner_id

    drop_table :campaigns_users do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :user, index: true
    end

    drop_table :campaigns_owners do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :user, index: true
    end
  end
end

