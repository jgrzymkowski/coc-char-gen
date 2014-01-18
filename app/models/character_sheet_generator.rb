class CharacterSheetGenerator
  include WeaponsHelper

  BASE_CHARACTER_SHEET = "#{Rails.root}/app/resources/coc6_1920_sheet.pdf"

  def initialize( character )
    @character = character
  end

  def generate
    c = @character
    filename = "#{Rails.root}/tmp/#{c.first_name}_#{c.last_name}_#{Time.now.to_i}.pdf"

    Prawn::Document.generate( filename, template: BASE_CHARACTER_SHEET ) do
      font("#{Rails.root}/app/resources/comicsans.ttf", size: 10)

      #general character info
      go_to_page 1
      draw_text "#{c.first_name} #{c.last_name}", at: [170, 710]
      draw_text c.occupation, at: [142, 696]
      draw_text c.degrees, at: [166, 682]
      draw_text c.birthplace, at: [140, 668]
      draw_text "", at: [169, 654]
      draw_text c.gender_read, at: [107, 640]
      draw_text c.age, at: [217, 640]

      draw_text c.player_name, at: [48 , 510], rotate: 90


      #characteristics
      if(c.characteristic_set)
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
        x_san -= 2 if san >= 0 && san < 10
        y_san = 599 - ((san+2)/17) * 15.6
        stroke do
          rounded_rectangle [x_san, y_san], 12, 12, 2
        end

        mag = c.characteristic_set.magic_points
        x_mag = 391 - ((3-(mag%8))%8) * 12.25
        x_mag -= 2 if mag >= 0 && mag < 10
        y_mag = 598 - ((mag+4)/8) * 15.6
        stroke do
          rounded_rectangle [x_mag, y_mag], 12, 12, 2
        end

        hit = c.characteristic_set.hit_points
        x_hit = 503 - ((3-(hit%8))%8) * 12.25
        x_hit -= 2 if hit >= 0 && hit < 10
        y_hit = 598 - ((hit+4)/8) * 15.6
        stroke do
          rounded_rectangle [x_hit, y_hit], 12, 12, 2
        end
      end

      font("#{Rails.root}/app/resources/comicsans.ttf", size: 8)

      #print skills
      if c.skill_set
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

        draw_text c.skill_set.handgun_val, at: [480, 197] if c.skill_set.handgun?
        draw_text c.skill_set.machine_gun_val, at: [480, 185] if c.skill_set.machine_gun?
        draw_text c.skill_set.rifle_val, at: [480, 173] if c.skill_set.rifle?
        draw_text c.skill_set.shotgun_val, at: [480, 161] if c.skill_set.shotgun?
        draw_text c.skill_set.SMG_val, at: [480, 149] if c.skill_set.SMG?

        #print melee skills
        draw_text c.skill_set.fist_val, at: [84, 86] if c.skill_set.fist?
        draw_text c.skill_set.grapple_val, at: [84, 72] if c.skill_set.grapple?
        draw_text c.skill_set.head_val, at: [84, 58] if c.skill_set.head?
        draw_text c.skill_set.kick_val, at: [84, 44] if c.skill_set.kick?
        draw_text c.skill_set.melee_val, at: [84, 30] if c.skill_set.melee?
        draw_text 'Melee (0%)', at: [32, 30] if c.skill_set.melee?
      end

      #print weapons
      i = 0
      c.weapons.each do |weapon|
        draw_text weapon.name.slice(0, 11), at: [275, 86-i]

        base = weapon.base.to_i
        case weapon.type
          when 'hand_to_hand'
            base += c.skill_set.melee if c.skill_set.melee
          when 'handgun'
            base += c.skill_set.handgun if c.skill_set.handgun?
          when 'rifle'
            base += c.skill_set.rifle if c.skill_set.rifle?
          when 'shotgun'
            base += c.skill_set.shotgun if c.skill_set.shotgun?
          when 'machine_gun'
            base += c.skill_set.machine_gun if c.skill_set.machine_gun?
          when 'smb'
            base += c.skill_set.SMB_val
        end
        draw_text base, at: [325, 86-i]

        font("#{Rails.root}/app/resources/comicsans.ttf", size: 5) if weapon.damage_done.length > 8
        draw_text weapon.damage_done, at: [349, 86-i]
        font("#{Rails.root}/app/resources/comicsans.ttf", size: 8)

        draw_text weapon.mal, at: [398, 86-i]

        range = weapon.base_range.split(' yards')[0]

        font("#{Rails.root}/app/resources/comicsans.ttf", size: 6) if range.length > 6
        draw_text range, at: [420, 86-i]
        font("#{Rails.root}/app/resources/comicsans.ttf", size: 8)

        draw_text weapon.attacks_per_round, at: [453, 86-i]

        draw_text weapon.bullets_in_gun, at: [480, 86-i]

        draw_text weapon.hps_resistance, at: [501, 86-i]
        i += 14
      end

      go_to_page 2
      font("#{Rails.root}/app/resources/comicsans.ttf", size: 9)

      #secondary skill info
      CharacterSheetGenerator.flowing_text_box 120,
                                           688,
                                           31,
                                           233,
                                           1,
                                           1,
                                           "#{c.first_name} #{c.last_name}",
                                           self

      CharacterSheetGenerator.flowing_text_box 83,
                                           674,
                                           31,
                                           233,
                                           1,
                                           1,
                                           c.residence,
                                           self

      CharacterSheetGenerator.flowing_text_box 130,
                                           660,
                                           31,
                                           233,
                                           3,
                                           1,
                                           c.personal_description,
                                           self

      CharacterSheetGenerator.flowing_text_box 114,
                                           618,
                                           31,
                                           233,
                                           4,
                                           1,
                                           c.family_and_friends,
                                           self

      CharacterSheetGenerator.flowing_text_box 280,
                                           674,
                                           280,
                                           233,
                                           2,
                                           1,
                                           c.episodes_of_insanity,
                                           self

      CharacterSheetGenerator.flowing_text_box 371,
                                           646,
                                           280,
                                           233,
                                           3,
                                           1,
                                           c.wounds_and_injuries,
                                           self

      CharacterSheetGenerator.flowing_text_box 358,
                                           604,
                                           280,
                                           233,
                                           3,
                                           1,
                                           c.marks_and_scars,
                                           self

      history = CharacterSheetGenerator.flowing_text_box 93,
                                                         518,
                                                         31,
                                                         233,
                                                         9,
                                                         3,
                                                         c.history,
                                                         self
      CharacterSheetGenerator.flowing_text_box 285,
                                               518,
                                               285,
                                               233,
                                               9,
                                               0,
                                               history,
                                               self

      CharacterSheetGenerator.flowing_text_box 67,
                                               342,
                                               67,
                                               208,
                                               1,
                                               0,
                                               c.income,
                                               self

      CharacterSheetGenerator.flowing_text_box 102,
                                               328,
                                               102,
                                               168,
                                               1,
                                               0,
                                               c.cash,
                                               self

      CharacterSheetGenerator.flowing_text_box 67,
                                               314,
                                               67,
                                               208,
                                               1,
                                               0,
                                               c.savings,
                                               self

      CharacterSheetGenerator.flowing_text_box 115,
                                               300,
                                               31,
                                               233,
                                               3,
                                               1,
                                               c.property,
                                               self

      CharacterSheetGenerator.flowing_text_box 88,
                                               258,
                                               31,
                                               233,
                                               2,
                                               1,
                                               c.real_estate,
                                               self

    end
    filename
  end

  def self.flowing_text_box( x_index, y_index, mid_x_index, mid_width, num_lines, indented_lines, text, prawn_doc )
    line_height = 14
    top_width = mid_width - x_index + mid_x_index
    excess = text
    indented_lines.times do |i|
      excess = prawn_doc.text_box excess,
                                  width:     top_width,
                                  height:    line_height,
                                  overflow:  :truncate,
                                  at:        [x_index, y_index]
      y_index -= line_height
    end

    (num_lines-indented_lines).times do |i|
      excess = prawn_doc.text_box excess,
                                  width: mid_width,
                                  height: line_height,
                                  overflow: :truncate,
                                  at: [mid_x_index, y_index]
      y_index -= line_height
    end
    excess
  end
end
