class SkillSet < ActiveRecord::Base
  belongs_to :character

  BASIC_SKILLS = {
      :accounting=>1, :anthropology=>1, :archaeology=>1, :astronomy=>1,
      :bargain=>5, :biology=>1, :chemistry=>1, :climb=>40, :conceal=>15,
      :credit_rating=>15, :cthulhu_mythos=>0, :disguise=>1, :dodge=>nil,
      :drive_auto=>20, :electrical_repair=>10, :fast_talk=>5,
      :first_aid=>30, :geology=>1, :hide=>10, :history=>20, :jump=>25,
      :law=>5, :library_use=>25, :listen=>25, :locksmith=>1,
      :martial_arts=>1, :mechanical_repair=>20, :medicine=>5,
      :natural_history=>10, :navigate=>10, :occult=>5,
      :operate_heavy_machine=>1, :own_language=>nil, :persuade=>15,
      :pharmacy=>1, :photography=>10, :physics=>1, :psychoanalysis=>1,
      :psychology=>5, :ride=>5, :sneak=>10, :spot_hidden=>25, :swim=>25,
      :throw=>25, :track=>10
  }

  SKILL_CATEGORIES = {
      art: 5, craft: 5, other_language: 1, pilot: 1
  }

  FIREARM_SKILLS = {
      :handgun=>20, :machine_gun=>15, :rifle=>25, :shotgun=>30, :SMG=>15
  }

  ALL_SKILLS = (BASIC_SKILLS.merge(SKILL_CATEGORIES).sort +
      FIREARM_SKILLS.to_a).reduce( {} ) { |m, a| m.merge!( a[0] => a[1]) }

  #todo test
  #SKILLS.each do |k, v|
  #  define_method( "#{k}_val" ) { eval(k) + v }
  #end
  #
  #SKILL_CATEGORIES.each do |k, v|
  #  define_method( "#{k}_val" ) do
  #    JSON.parse(v).keys.reduce( {} ) do |mem, key|
  #      mem.merge( key => h[key] + v )
  #    end
  #  end
  #end

end


#SKILLS = {
#    accounting: 1, anthropology: 1, archaeology: 1, art: 5,
#    astronomy: 1, bargain: 5, biology: 1, chemistry: 1, climb: 40,
#    conceal: 15, craft: 5, credit_rating: 15, cthulhu_mythos: 0,
#    disguise: 1, dodge: nil, drive_auto: 20, electrical_repair: 10,
#    fast_talk: 5, first_aid: 30, geology: 1, hide: 10, history: 20,
#    jump: 25, law: 5, library_use: 25, listen: 25, locksmith: 1,
#    martial_arts: 1, mechanical_repair: 20, medicine: 5,
#    natural_history: 10, navigate: 10, occult: 5,
#    operate_heavy_machine: 1, other_language: 1, own_language: nil,
#    persuade: 15, pharmacy: 1, photography: 10, physics: 1, pilot: 1,
#    psychoanalysis: 1, psychology: 5, ride: 5, sneak: 10,
#    spot_hidden: 25, swim: 25, thrown: 25, track: 10, handgun: 20,
#    machine_gun: 15, rifle: 25, shotgun: 30, SMG: 15
#}