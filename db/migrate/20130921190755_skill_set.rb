class SkillSet < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.string :skill_occupation
      [ :accounting, :anthropology, :archaeology, :astronomy, :bargain, :biology, :chemistry, :climb, :conceal, :credit_rating, :cthulhu_mythos, :disguise, :dodge, :drive_auto, :electrical_repair, :fast_talk, :first_aid, :geology, :hide, :history, :jump, :law, :library_use, :listen, :locksmith, :martial_arts, :mechanical_repair, :medicine, :natural_history, :navigate, :occult, :operate_heavy_machine, :own_language, :persuade, :pharmacy, :photography, :physics, :psychoanalysis, :psychology, :ride, :sneak, :spot_hidden, :swim, :throw, :track, :handgun, :machine_gun, :rifle, :shotgun, :SMG, :fist, :grapple, :head, :kick, :melee ].each do |skill|
        t.integer skill
      end

      [ :art, :craft, :other_language, :pilot, :other ].each do |skill|
        t.text skill
      end

      t.belongs_to :character
      t.timestamps
    end
  end
end
