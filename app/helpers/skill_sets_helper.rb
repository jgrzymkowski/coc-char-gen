module SkillSetsHelper
  include ApplicationHelper

  def table_title skill
    "#{sym_to_title skill} (#{skill_base skill}%)"
  end

  def skill_base skill
    case skill
      when :dodge
        if @character && @character.characteristic_set
          @character.characteristic_set.dexterity*2
        else
          'DEXx2'
        end
      when :own_language
        if @character && @character.characteristic_set
          @character.characteristic_set.education*5
        else
          'EDUx5'
        end
      else
        SkillSet::ALL_SKILLS[skill]
    end
  end

  def all_skills( character )
    SkillSet::ALL_SKILLS.merge(
        dodge: character.characteristic_set.dexterity * 2,
        own_language: character.characteristic_set.education * 5
    )
  end
end