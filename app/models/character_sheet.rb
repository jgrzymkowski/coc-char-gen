class CharacterSheet
  BASE_CHARACTER_SHEET = "#{Rails.root}/app/resources/coc6_1920_sheet.pdf"

  def initialize( character )
    @character = character
  end

  def generate
    c = @character
    filename = "#{Rails.root}/tmp/#{c.first_name}_#{c.last_name}_#{Time.now.to_i}.pdf"

    Prawn::Document.generate( filename, template: BASE_CHARACTER_SHEET ) do
      font("#{Rails.root}/app/resources/comicsans.ttf", size: 10)

      go_to_page 1
      draw_text "#{c.first_name} #{c.last_name}", at: [170, 710]
      draw_text "#{c.occupation}", at: [142, 696]
      draw_text "#{c.degrees}", at: [166, 682]
      draw_text "#{c.birthplace}", at: [140, 668]
      draw_text "", at: [169, 654]
      draw_text "#{c.gender_read}", at: [107, 640]
      draw_text "#{c.age}", at: [217, 640]

      draw_text c.characteristic_set.strength, at: [333, 686]
      draw_text c.characteristic_set.constitution, at: [333, 669]
      draw_text c.characteristic_set.size, at: [333, 653]
      draw_text c.characteristic_set.dexterity, at: [384, 686]
      draw_text c.characteristic_set.appearance, at: [384, 669]
      draw_text c.characteristic_set.sanity, at: [384, 653]
      draw_text c.characteristic_set.intelligence, at: [436, 686]
      draw_text c.characteristic_set.power, at: [436, 669]
      draw_text c.characteristic_set.education, at: [436, 653]
      draw_text c.characteristic_set.idea, at: [493, 686]
      draw_text c.characteristic_set.luck, at: [493, 669]
      draw_text c.characteristic_set.know, at: [493, 653]
      draw_text (99-c.characteristic_set.cthulhu_mythos), at: [378, 637]
      draw_text c.characteristic_set.damage_bonus, at: [470, 637]

      stroke_color 100, 100, 100, 100
      san = c.characteristic_set.sanity
      x_san = 278 - ((14-(san%17))%17) * 12.25
      y_san = 599 - ((san+2)/17) * 15.6
      stroke do
        rounded_rectangle [x_san, y_san], 12, 12, 2
      end

      mag = c.characteristic_set.magic_points
      x_mag = 391 - ((3-(mag%8))%8) * 12.25
      y_mag = 598 - ((mag+4)/8) * 15.6
      stroke do
        rounded_rectangle [x_mag, y_mag], 12, 12, 2
      end

      hit = c.characteristic_set.hit_points
      x_hit = 503 - ((3-(hit%8))%8) * 12.25
      y_hit = 598 - ((hit+4)/8) * 15.6
      stroke do
        rounded_rectangle [x_hit, y_hit], 12, 12, 2
      end

      font("#{Rails.root}/app/resources/comicsans.ttf", size: 8)

      draw_text c.skill_set.accounting_val, at: [192, 461] if c.skill_set.accounting?
      draw_text c.skill_set.anthropology_val, at: [192, 449] if c.skill_set.anthropology?
      draw_text c.skill_set.archaeology_val, at: [192, 437] if c.skill_set.archaeology?
      draw_text c.skill_set.art_val.to_a[0][0], at: [105, 413] if c.skill_set.art_val? 0
      draw_text c.skill_set.art_val.to_a[0][1], at: [192, 413] if c.skill_set.art_val? 0
      draw_text c.skill_set.art_val.to_a[1][0], at: [105, 401] if c.skill_set.art_val? 1
      draw_text c.skill_set.art_val.to_a[1][1], at: [192, 401] if c.skill_set.art_val? 1
      draw_text c.skill_set.astronomy_val, at: [192, 389] if c.skill_set.astronomy?
      draw_text c.skill_set.bargain_val, at: [192, 377] if c.skill_set.bargain?
      draw_text c.skill_set.biology_val, at: [192, 365] if c.skill_set.biology?
      draw_text c.skill_set.chemistry_val, at: [192, 353] if c.skill_set.chemistry?
      draw_text c.skill_set.climb_val, at: [192, 341] if c.skill_set.climb?
      draw_text c.skill_set.conceal_val, at: [192, 329] if c.skill_set.conceal?
      draw_text c.skill_set.craft_val.to_a[0][0], at: [105, 305] if c.skill_set.craft_val? 0
      draw_text c.skill_set.craft_val.to_a[0][1], at: [192, 305] if c.skill_set.craft_val? 0
      draw_text c.skill_set.craft_val.to_a[1][0], at: [105, 293] if c.skill_set.craft_val? 1
      draw_text c.skill_set.craft_val.to_a[1][1], at: [192, 293] if c.skill_set.craft_val? 1
      draw_text c.skill_set.credit_rating_val, at: [192, 281] if c.skill_set.credit_rating?
      draw_text c.skill_set.cthulhu_mythos_val, at: [192, 269] if c.skill_set.cthulhu_mythos?
      draw_text c.skill_set.disguise_val, at: [192, 257] if c.skill_set.disguise?
      draw_text c.skill_set.dodge_val, at: [192, 245] if c.skill_set.dodge?
      draw_text c.skill_set.drive_auto_val, at: [192, 233] if c.skill_set.drive_auto?
      draw_text c.skill_set.electrical_repair_val, at: [192, 221] if c.skill_set.electrical_repair?
      draw_text c.skill_set.fast_talk_val, at: [192, 209] if c.skill_set.fast_talk?
      draw_text c.skill_set.first_aid_val, at: [192, 197] if c.skill_set.first_aid?
      draw_text c.skill_set.geology_val, at: [192, 185] if c.skill_set.geology?
      draw_text c.skill_set.hide_val, at: [192, 173] if c.skill_set.hide?
      draw_text c.skill_set.history_val, at: [192, 161] if c.skill_set.history?
      draw_text c.skill_set.jump_val, at: [192, 149] if c.skill_set.jump?

      draw_text c.skill_set.law_val, at: [336, 461] if c.skill_set.law?
      draw_text c.skill_set.library_use_val, at: [336, 449] if c.skill_set.library_use?
      draw_text c.skill_set.listen_val, at: [336, 437] if c.skill_set.listen?
      draw_text c.skill_set.locksmith_val, at: [336, 425] if c.skill_set.locksmith?
      draw_text c.skill_set.martial_arts_val, at: [336, 413] if c.skill_set.martial_arts?
      draw_text c.skill_set.mechanical_repair_val, at: [336, 401] if c.skill_set.mechanical_repair?
      draw_text c.skill_set.medicine_val, at: [336, 389] if c.skill_set.medicine?
      draw_text c.skill_set.natural_history_val, at: [336, 377] if c.skill_set.natural_history?
      draw_text c.skill_set.navigate_val, at: [336, 365] if c.skill_set.navigate?
      draw_text c.skill_set.occult_val, at: [336, 353] if c.skill_set.occult?
      draw_text c.skill_set.operate_heavy_machine_val, at: [336, 341] if c.skill_set.operate_heavy_machine?
      draw_text c.skill_set.other_language_val.to_a[0][0], at: [249, 317] if c.skill_set.other_language_val? 0
      draw_text c.skill_set.other_language_val.to_a[0][1], at: [336, 317] if c.skill_set.other_language_val? 0
      draw_text c.skill_set.other_language_val.to_a[1][0], at: [249, 305] if c.skill_set.other_language_val? 1
      draw_text c.skill_set.other_language_val.to_a[1][1], at: [336, 305] if c.skill_set.other_language_val? 1
      draw_text c.skill_set.other_language_val.to_a[2][0], at: [249, 293] if c.skill_set.other_language_val? 2
      draw_text c.skill_set.other_language_val.to_a[2][1], at: [336, 293] if c.skill_set.other_language_val? 2
      draw_text c.skill_set.own_language_val, at: [336, 269] if c.skill_set.own_language?
      draw_text c.skill_set.persuade_val, at: [336, 257] if c.skill_set.persuade?
      draw_text c.skill_set.pharmacy_val, at: [336, 245] if c.skill_set.pharmacy?
      draw_text c.skill_set.photography_val, at: [336, 233] if c.skill_set.photography?
      draw_text c.skill_set.physics_val, at: [336, 221] if c.skill_set.physics?
      draw_text c.skill_set.pilot_val.to_a[0][0], at: [249, 197] if c.skill_set.pilot_val? 0
      draw_text c.skill_set.pilot_val.to_a[0][1], at: [336, 197] if c.skill_set.pilot_val? 0
      draw_text c.skill_set.pilot_val.to_a[1][0], at: [249, 185] if c.skill_set.pilot_val? 1
      draw_text c.skill_set.pilot_val.to_a[1][1], at: [336, 185] if c.skill_set.pilot_val? 1
      draw_text c.skill_set.psychoanalysis_val, at: [336, 173] if c.skill_set.psychoanalysis?
      draw_text c.skill_set.psychology_val, at: [336, 161] if c.skill_set.psychology?
      draw_text c.skill_set.ride_val, at: [336, 149] if c.skill_set.ride?

      draw_text c.skill_set.sneak_val, at: [480, 341] if c.skill_set.sneak?
      draw_text c.skill_set.spot_hidden_val, at: [480, 329] if c.skill_set.spot_hidden?
      draw_text c.skill_set.swim_val, at: [480, 317] if c.skill_set.swim?
      draw_text c.skill_set.throw_val, at: [480, 305] if c.skill_set.throw?
      draw_text c.skill_set.track_val, at: [480, 293] if c.skill_set.track?

      draw_text 'AB', at: [83, 86]
      draw_text 'CD', at: [83, 72]
      draw_text 'EF', at: [83, 58]
      draw_text 'GH', at: [83, 44]

      draw_text 'IJ', at: [325, 86]
      draw_text 'KL', at: [325, 72]
      draw_text 'MN', at: [325, 58]
      draw_text 'OP', at: [325, 44]

      draw_text '1D6+1', at: [353, 86]
      draw_text '10', at: [398, 86]
      draw_text '1/2', at: [453, 86]
      draw_text '100', at: [475, 86]
      draw_text '10', at: [501, 86]

      draw_text '2D6+1', at: [353, 72]
      draw_text '20', at: [398, 72]
      draw_text '2/2', at: [453, 72]
      draw_text '200', at: [475, 72]
      draw_text '20', at: [501, 72]

      draw_text '3D6+1', at: [353, 58]
      draw_text '30', at: [398, 58]
      draw_text '3/2', at: [453, 58]
      draw_text '300', at: [475, 58]
      draw_text '30', at: [501, 58]

      draw_text '4D6+1', at: [353, 44]
      draw_text '40', at: [398, 44]
      draw_text '4/2', at: [453, 44]
      draw_text '400', at: [475, 44]
      draw_text '40', at: [501, 44]

      #font("#{Rails.root}/app/resources/comicsans.ttf", size: 8)
      draw_text 'Gun 1', at: [280, 86]
      draw_text '100yds', at: [420, 86]

      draw_text 'Gun 2', at: [280, 72]
      draw_text '200yds', at: [420, 72]

      draw_text 'Gun 3', at: [280, 58]
      draw_text '300yds', at: [420, 58]

      draw_text 'Gun 4', at: [280, 44]
      draw_text '400yds', at: [420, 44]
    end
    filename
  end
end