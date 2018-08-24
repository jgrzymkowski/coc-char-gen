class Coc::Weapon
  attr_accessor :id, :type, :name, :base, :damage_done, :base_range, :attacks_per_round, :bullets_in_gun, :hps_resistance, :cost, :mal, :common_in_era

  def initialize( properties )
    @id = properties[:id]
    @type = properties[:type]
    @name = properties[:name]
    @base = properties[:base]
    @damage_done = properties[:damage_done]
    @base_range = properties[:base_range]
    @attacks_per_round = properties[:attacks_per_round]
    @bullets_in_gun = properties[:bullets_in_gun]
    @hps_resistance = properties[:hps_resistance]
    @cost = properties[:cost]
    @mal = properties[:mal]
    @common_in_era = properties[:common_in_era]
  end
end
