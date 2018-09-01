# == Schema Information
#
# Table name: dg_skill_sets
#
#  id               :integer          not null, primary key
#  accounting       :integer
#  alertness        :integer
#  anthropology     :integer
#  archeology       :integer
#  art              :integer
#  artillery        :integer
#  athletics        :integer
#  bureaucracy      :integer
#  computer_science :integer
#  craft            :integer
#  criminology      :integer
#  demolitions      :integer
#  disguise         :integer
#  dodge            :integer
#  drive            :integer
#  firearms         :integer
#  first_aid        :integer
#  forensics        :integer
#  humint           :integer
#  heavy_machinery  :integer
#  heavy_weapons    :integer
#  history          :integer
#  law              :integer
#  medicine         :integer
#  melee_weapons    :integer
#  military_science :integer
#  navigate         :integer
#  occult           :integer
#  persuade         :integer
#  pharmacy         :integer
#  pilot            :integer
#  psychotherapy    :integer
#  ride             :integer
#  sigint           :integer
#  science          :integer
#  search           :integer
#  stealth          :integer
#  surgery          :integer
#  survival         :integer
#  swim             :integer
#  unarmed_combat   :integer
#  unnatural        :integer
#  strength         :integer
#  constitution     :integer
#  dexterity        :integer
#  intelligence     :integer
#  power            :integer
#  charisma         :integer
#  character_id     :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Dg::SkillSet < ActiveRecord::Base
  belongs_to :character, class_name: 'Dg::Character'

  def skills
    attributes.reject do |k, v|
      ['id', 'character_id', 'created_at', 'updated_at'].include?(k)
    end
  end
end
