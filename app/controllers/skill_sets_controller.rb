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
    character.skill_set.update_attributes params[:skill_set]
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
      names = skill_set["sub_#{k}"]
      values = skill_set[k]
      h = {}
      names.each_index do |i|
        h[names[i]] = values[i]
      end
      m.merge( k => h.to_json)
    end
  end

end