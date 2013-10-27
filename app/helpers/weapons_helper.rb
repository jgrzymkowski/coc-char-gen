module WeaponsHelper
  include ApplicationHelper

  def all_weapons
    load_weapons_yaml.reduce({}) do |memo, h|
      memo.merge!( h[:id] => Weapon.new( h ) )
    end
  end

  def weapon_by_id( id )
    all_weapons[id]
  end

  private
  def load_weapons_yaml
    YAML.load_file(Rails.root.join 'app', 'resources', 'weapons.yml')
  end

end