class AddSystemToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :game_system_id, :string
  end
end
