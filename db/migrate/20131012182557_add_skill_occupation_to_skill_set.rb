class AddSkillOccupationToSkillSet < ActiveRecord::Migration
  def change
    add_column :skill_sets, :occupation_skills, :string
  end
end
