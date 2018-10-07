class AddPackageOptions < ActiveRecord::Migration
  def change
    add_column :dg_skill_sets, :occupation_options, :jsonb
    add_column :dg_skill_sets, :bonus_skill_package_options, :jsonb
    add_column :dg_characters, :bonds, :string, array: true, default: []
  end
end
