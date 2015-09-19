class SkillSetsController < ApplicationController

  #TODO figure this out
  SKILL_SET_ATTRIBUTES = [:id, :skill_occupation, :accounting, :anthropology, :archaeology, :astronomy, :bargain, :biology, :chemistry, :climb, :conceal, :credit_rating, :cthulhu_mythos, :disguise, :dodge, :drive_auto, :electrical_repair, :fast_talk, :first_aid, :geology, :hide, :history, :jump, :law, :library_use, :listen, :locksmith, :martial_arts, :mechanical_repair, :medicine, :natural_history, :navigate, :occult, :operate_heavy_machine, :own_language, :persuade, :pharmacy, :photography, :physics, :psychoanalysis, :psychology, :ride, :sneak, :spot_hidden, :swim, :throw, :track, :handgun, :machine_gun, :rifle, :shotgun, :SMG, :fist, :grapple, :head, :kick, :melee, :art, :craft, :other_language, :pilot, :other, :character_id, :created_at, :updated_at, :occupation_skills, :other_language0_title, :other_language0_val, :other_language1_title, :other_language1_val, :other_language2_title, :other_language2_val, :art0_title, :art0_val, :art1_title, :art1_val, :art2_title, :art2_val, :pilot0_title, :pilot0_val, :pilot1_title, :pilot1_val, :craft0_title, :craft0_val, :craft1_title, :craft1_val]
  def new
    @character = Character.find params[ :character_id ]
  end

  def create
    character = Character.find params[ :character_id ]

    skill_hash = params.require(:skill_set).permit(SKILL_SET_ATTRIBUTES)

    new_skill_set = extract_skill_sets skill_hash
    new_skill_set.merge!( extract_sub_skill_sets skill_hash )

    character.create_skill_set new_skill_set
    redirect_to character_path character
  end

  def edit
    @character = Character.find params[ :character_id ]
  end

  def update
    character = Character.find params[ :character_id ]
    skill_hash = params.require(:skill_set).permit(SKILL_SET_ATTRIBUTES)
    new_skill_set = extract_skill_occupation skill_hash
    new_skill_set.merge!( extract_skill_sets skill_hash )
    new_skill_set.merge!( extract_sub_skill_sets skill_hash )
    puts new_skill_set
    character.skill_set.update_attributes new_skill_set
    redirect_to character_path character
  end


  private
  def extract_skill_sets( skill_set )
    skill_set.select do |k,v|
      SkillSet::ALL_SKILLS.reject do |k,v|
        SkillSet::SKILL_CATEGORIES.keys.include? k
      end.keys.include? k.to_sym
    end
  end

  def extract_sub_skill_sets( skill_set )
    SkillSet::SKILL_CATEGORIES.reduce({}) do |m, s|
      k = s[0].to_s
      h = {}
      [0,1,2].each do |i|
        unless !skill_set["#{k}#{i}_val"] || skill_set["#{k}#{i}_val"].blank?
          h.merge!( skill_set["#{k}#{i}_title"] => skill_set["#{k}#{i}_val"] )
          skill_set.delete "#{k}#{i}_title"
          skill_set.delete "#{k}#{i}_val"
        end
        skill_set.delete "#{k}#{i}_title"
        skill_set.delete "#{k}#{i}_val"
      end
      m.merge( s[0] => h.to_json )
    end
  end

  def extract_skill_occupation( skill_set )
    { skill_occupation: skill_set[:skill_occupation],
      occupation_skills: skill_set[:occupation_skills] }
  end

end
