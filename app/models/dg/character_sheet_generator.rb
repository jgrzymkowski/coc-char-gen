class Dg::CharacterSheetGenerator
  include Coc::WeaponsHelper

  BASE_CHARACTER_SHEET = "#{Rails.root}/app/resources/dg_sheet.pdf"

  # for testing:
  # stats.update(strength: 16, constitution: 15, dexterity: 14, intelligence: 13, power: 12, charisma: 11)
  # skills.update({"accounting"=>21, "alertness"=>22, "anthropology"=>23, "archeology"=>24, "art_1"=>25, "art_2"=>26, "art_3"=>27, "artillery"=>28, "athletics"=>29, "bureaucracy"=>30, "computer_science"=>31, "craft_1"=>32, "craft_2"=>33, "craft_3"=>34, "criminology"=>35, "demolitions"=>36, "disguise"=>37, "dodge"=>38, "drive"=>39, "firearms"=>40, "first_aid"=>41, "forensics"=>42, "humint"=>43, "heavy_machinery"=>44, "heavy_weapons"=>45, "history"=>46, "law"=>47, "medicine"=>48, "melee_weapons"=>49, "military_science_1"=>50, "military_science_2"=>51, "military_science_3"=>52, "navigate"=>53, "occult"=>54, "persuade"=>55, "pharmacy"=>56, "pilot_1"=>57, "pilot_2"=>58, "pilot_3"=>59, "psychotherapy"=>60, "ride"=>61, "sigint"=>62, "science_1"=>63, "science_2"=>64, "science_3"=>65, "search"=>66, "stealth"=>67, "surgery"=>68, "survival"=>69, "swim"=>70, "unarmed_combat"=>71, "unnatural"=>72, "foreign_language_1"=>73, "foreign_language_2"=>74, "foreign_language_3"=>75, "art_1_text"=>"Test Value", "art_2_text"=>"Test Value", "art_3_text"=>"Test Value", "craft_1_text"=>"Test Value", "craft_2_text"=>"Test Value", "craft_3_text"=>"Test Value", "military_science_1_text"=>"Test Value", "military_science_2_text"=>"Test Value", "military_science_3_text"=>"Test Value", "pilot_1_text"=>"Test Value", "pilot_2_text"=>"Test Value", "pilot_3_text"=>"Test Value", "science_1_text"=>"Test Value", "science_2_text"=>"Test Value", "science_3_text"=>"Test Value", "foreign_language_1_text"=>"Test Value", "foreign_language_2_text"=>"Test Value", "foreign_language_3_text"=>"Test Value"})

  def initialize( character )
    @character = character
  end

  def generate
    character_pdf_filename = generate_character_pdf
    combine_pdfs(character_pdf_filename)
  end

  def combine_pdfs(character_pdf_filename)
    combined_pdf = CombinePDF.load(BASE_CHARACTER_SHEET)
    character_pdf = CombinePDF.load(character_pdf_filename)
    combined_pdf.pages.each_index do |i|
      combined_pdf.pages[i] << character_pdf.pages[i]
    end
    combined_pdf_filename = "#{filename_prefix}.pdf"
    combined_pdf.save(combined_pdf_filename)
    combined_pdf_filename
  end

  def filename_prefix
    @filename_prefix ||= "#{Rails.root}/tmp/#{@character.first_name}_#{@character.last_name}_#{Time.now.to_i}"
  end

  def generate_character_pdf
    c = @character
    filename = "#{filename_prefix}_character_info.pdf"

    Prawn::Document.generate( filename ) do
      font("#{Rails.root}/app/resources/comicsans.ttf", size: 10)

      # general character info
      x_1 = 50
      x_2 = 320

      y_1 = 659
      y_2 = 631
      y_3 = 604
      draw_text "#{c.first_name} #{c.last_name} (#{c.alias})", at: [x_1, y_1]
      draw_text c.profession, at: [x_2, y_1]
      draw_text c.employer, at: [x_1, y_2]
      draw_text c.nationality, at: [x_2, y_2]
      draw_text c.gender == 'f' ? 'Female': c.gender == 'm' ? 'Male' : '', at: [x_1+50, y_3+3]
      draw_text c.display_age_and_dob, at: [x_1+96, y_3]
      draw_text c.education_and_occupational_history, at: [x_1+190, y_3]


      if(c.statistic_set)
        x_1 = 110
        x_2 = 145
        x_3 = 176

        y_1 = 570
        y_2 = 552
        y_3 = 534
        y_4 = 516
        y_5 = 498
        y_6 = 480
        y_7 = 448
        y_8 = 430
        y_9 = 412
        y_10 = 394

        draw_text c.statistic_set.strength, at: [x_1, y_1]
        draw_text c.statistic_set.constitution, at: [x_1, y_2]
        draw_text c.statistic_set.dexterity, at: [x_1, y_3]
        draw_text c.statistic_set.intelligence, at: [x_1, y_4]
        draw_text c.statistic_set.power, at: [x_1, y_5]
        draw_text c.statistic_set.charisma, at: [x_1, y_6]

        draw_text c.statistic_set.strength*5, at: [x_2, y_1]
        draw_text c.statistic_set.constitution*5, at: [x_2, y_2]
        draw_text c.statistic_set.dexterity*5, at: [x_2, y_3]
        draw_text c.statistic_set.intelligence*5, at: [x_2, y_4]
        draw_text c.statistic_set.power*5, at: [x_2, y_5]
        draw_text c.statistic_set.charisma*5, at: [x_2, y_6]

        draw_text c.statistic_set.hit_points, at: [x_3, y_7]
        draw_text c.statistic_set.willpower, at: [x_3, y_8]
        draw_text c.statistic_set.sanity, at: [x_3, y_9]
        draw_text c.statistic_set.breaking_point, at: [x_3, y_10]
      end

      if(c.skill_set)
        x_1 = 174
        x_2 = 332
        x_3 = 495
        x_4 = 56
        x_5 = 216
        x_6 = 378

        y_1 = 325
        y_2 = y_1-18
        y_3 = y_1-(18)*2
        y_4 = y_1-(18)*3
        y_5 = y_1-(18)*4
        y_6 = y_1-(18)*5
        y_7 = y_1-(18)*6
        y_8 = y_1-(18)*7
        y_9 = y_1-(18)*8
        y_10 = y_1-(18)*9
        y_11 = y_1-(18)*10
        y_12 = y_1-(18)*11
        y_13 = y_1-(18)*12
        y_14 = y_1-(18)*13
        y_15 = y_1-(18)*14
        y_16 = y_1-(18)*15
        y_17 = y_1-(18)*16
        y_18 = y_1-(18)*17

        bonds_x = 488
        bonds_y = 570
        c.skill_set.bonds.times do |i|
          draw_text c.statistic_set.charisma, at: [bonds_x, bonds_y - (i)*18]
        end

        # 1st column

        draw_text c.skill_set.accounting, at: [x_1, y_1]
        draw_text c.skill_set.alertness, at: [x_1, y_2]
        draw_text c.skill_set.anthropology, at: [x_1, y_3]
        draw_text c.skill_set.archeology, at: [x_1, y_4]

        draw_text c.skill_set.art_1 == 0 ? '' : c.skill_set.art_1, at: [x_1, y_4-14]
        draw_text c.skill_set.art_2 == 0 ? '' : c.skill_set.art_2, at: [x_1, y_4-26]
        draw_text c.skill_set.art_3 == 0 ? '' : c.skill_set.art_3, at: [x_1, y_4-38]
        draw_text c.skill_set.art_1_text, at: [x_4, y_4-14]
        draw_text c.skill_set.art_2_text, at: [x_4, y_4-26]
        draw_text c.skill_set.art_3_text, at: [x_4, y_4-38]

        draw_text c.skill_set.artillery, at: [x_1, y_7]
        draw_text c.skill_set.athletics, at: [x_1, y_8]
        draw_text c.skill_set.bureaucracy, at: [x_1, y_9]
        draw_text c.skill_set.computer_science, at: [x_1, y_10]

        draw_text c.skill_set.craft_1 == 0 ? '' : c.skill_set.craft_1, at: [x_1, y_10-14]
        draw_text c.skill_set.craft_2 == 0 ? '' : c.skill_set.craft_2, at: [x_1, y_10-26]
        draw_text c.skill_set.craft_3 == 0 ? '' : c.skill_set.craft_3, at: [x_1, y_10-38]
        draw_text c.skill_set.craft_1_text, at: [x_4, y_10-14]
        draw_text c.skill_set.craft_2_text, at: [x_4, y_10-26]
        draw_text c.skill_set.craft_3_text, at: [x_4, y_10-38]

        draw_text c.skill_set.criminology, at: [x_1, y_13]
        draw_text c.skill_set.demolitions, at: [x_1, y_14]
        draw_text c.skill_set.disguise, at: [x_1, y_15]
        draw_text c.skill_set.dodge, at: [x_1, y_16]
        draw_text c.skill_set.drive, at: [x_1, y_17]
        draw_text c.skill_set.firearms, at: [x_1, y_18]

        # 2nd column

        draw_text c.skill_set.first_aid, at: [x_2, y_1]
        draw_text c.skill_set.forensics, at: [x_2, y_2]
        draw_text c.skill_set.heavy_machinery, at: [x_2, y_3]
        draw_text c.skill_set.heavy_weapons, at: [x_2, y_4]
        draw_text c.skill_set.history, at: [x_2, y_5]
        draw_text c.skill_set.humint, at: [x_2, y_6]
        draw_text c.skill_set.law, at: [x_2, y_7]
        draw_text c.skill_set.medicine, at: [x_2, y_8]
        draw_text c.skill_set.melee_weapons, at: [x_2, y_9]

        draw_text c.skill_set.military_science_1 == 0 ? '' : c.skill_set.military_science_1, at: [x_2, y_9-14]
        draw_text c.skill_set.military_science_2 == 0 ? '' : c.skill_set.military_science_2, at: [x_2, y_9-26]
        draw_text c.skill_set.military_science_3 == 0 ? '' : c.skill_set.military_science_3, at: [x_2, y_9-38]
        draw_text c.skill_set.military_science_1_text, at: [x_5, y_9-14]
        draw_text c.skill_set.military_science_2_text, at: [x_5, y_9-26]
        draw_text c.skill_set.military_science_3_text, at: [x_5, y_9-38]

        draw_text c.skill_set.navigate, at: [x_2, y_12]
        draw_text c.skill_set.occult, at: [x_2, y_13]
        draw_text c.skill_set.persuade, at: [x_2, y_14]
        draw_text c.skill_set.pharmacy, at: [x_2, y_15]

        draw_text c.skill_set.pilot_1 == 0 ? '' : c.skill_set.pilot_1, at: [x_2, y_15-14]
        draw_text c.skill_set.pilot_2 == 0 ? '' : c.skill_set.pilot_2, at: [x_2, y_15-26]
        draw_text c.skill_set.pilot_3 == 0 ? '' : c.skill_set.pilot_3, at: [x_2, y_15-38]
        draw_text c.skill_set.pilot_1_text, at: [x_5, y_15-14]
        draw_text c.skill_set.pilot_2_text, at: [x_5, y_15-26]
        draw_text c.skill_set.pilot_3_text, at: [x_5, y_15-38]

        draw_text c.skill_set.psychotherapy, at: [x_2, y_18]

        # 3rd column

        draw_text c.skill_set.ride, at: [x_3, y_1]

        draw_text c.skill_set.science_1 == 0 ? '' : c.skill_set.science_1, at: [x_3, y_1-14]
        draw_text c.skill_set.science_2 == 0 ? '' : c.skill_set.science_2, at: [x_3, y_1-26]
        draw_text c.skill_set.science_3 == 0 ? '' : c.skill_set.science_3, at: [x_3, y_1-38]
        draw_text c.skill_set.science_1_text, at: [x_6, y_1-14]
        draw_text c.skill_set.science_2_text, at: [x_6, y_1-26]
        draw_text c.skill_set.science_3_text, at: [x_6, y_1-38]

        draw_text c.skill_set.search, at: [x_3, y_4]
        draw_text c.skill_set.sigint, at: [x_3, y_5]
        draw_text c.skill_set.stealth, at: [x_3, y_6]
        draw_text c.skill_set.surgery, at: [x_3, y_7]
        draw_text c.skill_set.survival, at: [x_3, y_8]
        draw_text c.skill_set.swim, at: [x_3, y_9]
        draw_text c.skill_set.unarmed_combat, at: [x_3, y_10]
        draw_text c.skill_set.unnatural, at: [x_3, y_11]

        draw_text c.skill_set.foreign_language_1 == 0 ? '' : c.skill_set.foreign_language_1, at: [x_3, y_13]
        draw_text c.skill_set.foreign_language_2 == 0 ? '' : c.skill_set.foreign_language_2, at: [x_3, y_14]
        draw_text c.skill_set.foreign_language_3 == 0 ? '' : c.skill_set.foreign_language_3, at: [x_3, y_15]
        draw_text c.skill_set.foreign_language_1_text, at: [x_6, y_13]
        draw_text c.skill_set.foreign_language_2_text, at: [x_6, y_14]
        draw_text c.skill_set.foreign_language_3_text, at: [x_6, y_15]
      end

      start_new_page
    end
    filename
  end
end
