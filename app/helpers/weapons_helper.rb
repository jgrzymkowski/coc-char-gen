module WeaponsHelper
  include ApplicationHelper

    def all_weapons
    load_weapons_yaml.map do |h|
      Weapon.new h
    end
  end

  private
  def load_weapons_yaml
    YAML.load_file(Rails.root.join 'app', 'resources', 'weapons.yml')
  end

end