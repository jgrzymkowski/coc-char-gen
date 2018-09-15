class AddPackageOptions < ActiveRecord::Migration
  def change
    add_column :dg_skill_sets, :bonus_skill_package_options, :jsonb
  end
end
