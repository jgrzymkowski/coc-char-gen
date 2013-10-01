module SkillSetsHelper
  include ApplicationHelper

  def table_title skill
    case skill
      when :dodge
        if @character && @character.characteristic_set
          "#{sym_to_title skill } (#{@character.characteristic_set.dexterity*2}%)"
        else
          "#{sym_to_title skill } (DEXx2%)"
        end
      when :own_language
        if @character && @character.characteristic_set
          "#{sym_to_title skill } (#{@character.characteristic_set.education*5}%)"
        else
          "#{sym_to_title skill } (EDUx5%)"
        end
      else
        "#{sym_to_title skill } (#{SkillSet::ALL_SKILLS[skill]}%)"
    end
  end

  def all_skills( character )
    SkillSet::ALL_SKILLS.merge(
        dodge: character.characteristic_set.dexterity * 2,
        own_language: character.characteristic_set.education * 5
    )
  end
end