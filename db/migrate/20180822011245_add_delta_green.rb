class AddDeltaGreen < ActiveRecord::Migration
  def change
    rename_table :characters, :coc_characters
    rename_table :characteristic_sets, :coc_characteristic_sets
    rename_table :skill_sets, :coc_skill_sets
    rename_table :campaigns, :coc_campaigns

    add_column :campaigns_users, :campaign_type, :text
    remove_index :campaigns_users, name: :index_campaigns_users_on_user_id
    add_index :campaigns_users, [:campaign_id, :campaign_type], name: :index_campaigns_users_campaign

    add_column :campaigns_owners, :campaign_type, :text
    remove_index :campaigns_owners, name: :index_campaigns_owners_on_campaign_id
    add_index :campaigns_owners, [:campaign_id, :campaign_type], name: :index_campaigns_owners_campaign
  end
end

