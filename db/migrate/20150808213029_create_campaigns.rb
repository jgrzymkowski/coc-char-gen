class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :campaigns_users do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :user, index: true
    end

    create_table :campaigns_owners do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :user, index: true
    end
  end
end
