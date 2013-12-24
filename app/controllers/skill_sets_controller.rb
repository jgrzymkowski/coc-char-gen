class SkillSetsController < ApplicationController
  def new
    @character = Character.find params[ :character_id ]
  end

  def create
    character = Character.find params[ :character_id ]

    skill_hash = params['skill_set']

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
    skill_hash = params['skill_set']
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