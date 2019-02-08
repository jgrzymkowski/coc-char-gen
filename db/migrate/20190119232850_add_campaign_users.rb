class AddCampaignUsers < ActiveRecord::Migration
  def change
    create_table :campaign_users do |t|
      t.references :user
      t.references :campaign, polymorphic: true
      t.timestamps
    end
  end
end
