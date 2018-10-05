# == Schema Information
#
# Table name: dg_skill_sets
#
#  id                      :integer          not null, primary key
#  accounting              :integer
#  alertness               :integer
#  anthropology            :integer
#  archeology              :integer
#  art_1                   :integer
#  art_2                   :integer
#  art_3                   :integer
#  art_1_text              :string
#  art_2_text              :string
#  art_3_text              :string
#  artillery               :integer
#  athletics               :integer
#  bureaucracy             :integer
#  computer_science        :integer
#  craft_1                 :integer
#  craft_2                 :integer
#  craft_3                 :integer
#  craft_1_text            :string
#  craft_2_text            :string
#  craft_3_text            :string
#  criminology             :integer
#  demolitions             :integer
#  disguise                :integer
#  dodge                   :integer
#  drive                   :integer
#  firearms                :integer
#  first_aid               :integer
#  forensics               :integer
#  humint                  :integer
#  heavy_machinery         :integer
#  heavy_weapons           :integer
#  history                 :integer
#  law                     :integer
#  medicine                :integer
#  melee_weapons           :integer
#  military_science_1      :integer
#  military_science_2      :integer
#  military_science_3      :integer
#  military_science_1_text :string
#  military_science_2_text :string
#  military_science_3_text :string
#  navigate                :integer
#  occult                  :integer
#  persuade                :integer
#  pharmacy                :integer
#  pilot_1                 :integer
#  pilot_2                 :integer
#  pilot_3                 :integer
#  pilot_1_text            :string
#  pilot_2_text            :string
#  pilot_3_text            :string
#  psychotherapy           :integer
#  ride                    :integer
#  sigint                  :integer
#  science_1               :integer
#  science_2               :integer
#  science_3               :integer
#  science_1_text          :string
#  science_2_text          :string
#  science_3_text          :string
#  search                  :integer
#  stealth                 :integer
#  surgery                 :integer
#  survival                :integer
#  swim                    :integer
#  unarmed_combat          :integer
#  unnatural               :integer
#  foreign_language_1      :integer
#  foreign_language_2      :integer
#  foreign_language_3      :integer
#  foreign_language_1_text :string
#  foreign_language_2_text :string
#  foreign_language_3_text :string
#  character_id            :integer
#  occupation              :string
#  bonds                   :integer
#  bonus_skill_package     :string
#  created_at              :datetime
#  updated_at              :datetime
#

class Dg::SkillSet < ActiveRecord::Base
  belongs_to :character, class_name: 'Dg::Character'

  def skills
    attributes.reject do |k, v|
      %w(id character_id created_at updated_at occupation bonds bonus_skill_package bonus_skill_package_options).include?(k)
    end
  end
end
