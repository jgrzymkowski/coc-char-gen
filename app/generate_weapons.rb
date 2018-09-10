weapons = []
last_weapon = {:id=>0, :name => '', :type=>"", :base=>"", :damage_done => '', :range => '', :attacks_per_round => '', :bullets_in_gun => '', :hps_resistance => '', :cost => '', mal: '', :common_in_era=>["1890", "1920", "present"]}
id = 27
last_weapon = {}
while true
  weapon = {}
  weapon[:id] = id
  puts 'type:'
  type = gets.chomp
  type = type == '' ? last_weapon[:type] : type
  weapon.merge!(type: type)

  puts 'name:'
  name = gets.chomp
  name = name == '' ? last_weapon[:name] : name
  weapon.merge!(name: name)

  puts 'base_chance:'
  base = gets.chomp
  base = base == '' ? last_weapon[:base] : base
  weapon.merge!(base: base)

  puts 'damage_done:'
  dmg = gets.chomp
  dmg = dmg == '' ? last_weapon[:damage_done] : dmg
  weapon.merge!(damage_done: dmg)

  puts 'base_range:'
  range = gets.chomp
  range = range == '' ? last_weapon[:range] : range
  weapon.merge!(base_range: range)

  puts 'attacks_per_round:'
  attacks = gets.chomp
  attacks = attacks == '' ? last_weapon[:attacks_per_round] : attacks
  weapon.merge!(attacks_per_round: attacks)

  puts 'bullets:'
  bullets = gets.chomp
  bullets = bullets == '' ? last_weapon[:bullets_in_gun] : bullets
  weapon.merge!(bullets_in_gun: bullets)

  puts 'resistance:'
  resistance = gets.chomp
  resistance = resistance == '' ? last_weapon[:hps_resistance] : resistance
  weapon.merge!(hps_resistance: resistance)

  puts 'cost:'
  cost = gets.chomp.split(',')
  cost = cost == '' ? last_weapon[:cost] : cost
  weapon.merge!(cost: cost)

  puts 'malfunction:'
  mal = gets.chomp
  mal = mal == '' ? last_weapon[:mal] : mal
  weapon.merge!(mal: mal)

  puts 'eras'
  eras = gets.chomp.split(',')
  eras = eras == [] ? last_weapon[:common_in_era].dup : eras
  eras = ['1890', '1920', 'present'] if(eras == ['all'])
  weapon.merge!(common_in_era: eras)

  weapons << weapon
  last_weapon = weapon
  id = id+1

  puts 'end?'
  endy = gets.chomp
  if endy == 'y'
    File.write('weaponsweapons.txt', weapons.inspect)
    break
  end
end
