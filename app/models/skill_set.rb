class SkillSet < ActiveRecord::Base
  belongs_to :character
  attr_accessible :skill_occupation, :occupation_skills, :accounting, :anthropology, :archaeology, :art, :astronomy, :bargain, :biology, :chemistry, :climb, :conceal, :craft, :credit_rating, :cthulhu_mythos, :disguise, :dodge, :drive_auto, :electrical_repair, :fast_talk, :first_aid, :geology, :hide, :history, :jump, :law, :library_use, :listen, :locksmith, :martial_arts, :mechanical_repair, :medicine, :natural_history, :navigate, :occult, :operate_heavy_machine, :other_language, :own_language, :persuade, :pharmacy, :photography, :physics, :pilot, :psychoanalysis, :psychology, :ride, :sneak, :spot_hidden, :swim, :throw, :track, :handgun, :machine_gun, :rifle, :shotgun, :SMG, :fist, :grapple, :head, :kick, :melee

  BASIC_SKILLS = {
      accounting: 1, anthropology: 1, archaeology: 1, astronomy: 1,
      bargain: 5, biology: 1, chemistry: 1, climb: 40, conceal: 15,
      credit_rating: 15, cthulhu_mythos: 0, disguise: 1, dodge: nil,
      drive_auto: 20, electrical_repair: 10, fast_talk: 5,
      first_aid: 30, geology: 1, hide: 10, history: 20, jump: 25,
      law: 5, library_use: 25, listen: 25, locksmith: 1,
      martial_arts: 1, mechanical_repair: 20, medicine: 5,
      natural_history: 10, navigate: 10, occult: 5,
      operate_heavy_machine: 1, own_language: nil, persuade: 15,
      pharmacy: 1, photography: 10, physics: 1, psychoanalysis: 1,
      psychology: 5, ride: 5, sneak: 10, spot_hidden: 25, swim: 25,
      throw: 25, track: 10
  }

  SKILL_CATEGORIES = {
      art: 5, craft: 5, other_language: 1, pilot: 1
  }

  FIREARM_SKILLS = {
      handgun: 20, machine_gun: 15, rifle: 25, shotgun: 30, SMG: 15
  }

  MELEE_SKILLS = {
      fist: 50, grapple: 25, head: 10, kick: 25, melee: 0
  }

  ALL_SKILLS = (BASIC_SKILLS.merge(SKILL_CATEGORIES).sort +
      FIREARM_SKILLS.to_a + MELEE_SKILLS.to_a).reduce( {} ) do |m, a|
    m.merge!( a[0] => a[1])
  end

  ALL_SKILLS.each do |k, v|
    define_method( "#{k}_val" ) do
      puts '*'*10
      puts k.inspect
      if SKILL_CATEGORIES.keys.include? k
        JSON.parse(eval(k.to_s)).reduce({}) do |m, pair|
          m.merge!( pair[0] => pair[1].to_i + v )
        end
      elsif (k.to_s == 'dodge')
        eval(k.to_s).to_i + character.characteristic_set.dexterity*2
      elsif (k.to_s == 'own_language')
        eval(k.to_s).to_i + character.characteristic_set.education*5
      else
        self.send(k.to_s).to_i + v
      end
    end
  end

  SKILL_CATEGORIES.each do |k, v|
    define_method( "#{k}_val?" ) do |i|
      !!JSON.parse(eval(k.to_s)).to_a[i] &&
        !JSON.parse(eval(k.to_s)).to_a[i][0].blank?
    end
    define_method("#{k}_hash") do
      JSON.parse(eval(k.to_s))
    end
  end
end