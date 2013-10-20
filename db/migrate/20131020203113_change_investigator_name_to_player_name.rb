class ChangeInvestigatorNameToPlayerName < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.rename :investigator_name, :player_name
    end
  end
end
