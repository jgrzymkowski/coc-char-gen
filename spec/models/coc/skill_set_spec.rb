# == Schema Information
#
# Table name: skill_sets
#
#  id                    :integer          not null, primary key
#  skill_occupation      :string
#  accounting            :integer
#  anthropology          :integer
#  archaeology           :integer
#  astronomy             :integer
#  bargain               :integer
#  biology               :integer
#  chemistry             :integer
#  climb                 :integer
#  conceal               :integer
#  credit_rating         :integer
#  cthulhu_mythos        :integer
#  disguise              :integer
#  dodge                 :integer
#  drive_auto            :integer
#  electrical_repair     :integer
#  fast_talk             :integer
#  first_aid             :integer
#  geology               :integer
#  hide                  :integer
#  history               :integer
#  jump                  :integer
#  law                   :integer
#  library_use           :integer
#  listen                :integer
#  locksmith             :integer
#  martial_arts          :integer
#  mechanical_repair     :integer
#  medicine              :integer
#  natural_history       :integer
#  navigate              :integer
#  occult                :integer
#  operate_heavy_machine :integer
#  own_language          :integer
#  persuade              :integer
#  pharmacy              :integer
#  photography           :integer
#  physics               :integer
#  psychoanalysis        :integer
#  psychology            :integer
#  ride                  :integer
#  sneak                 :integer
#  spot_hidden           :integer
#  swim                  :integer
#  throw                 :integer
#  track                 :integer
#  handgun               :integer
#  machine_gun           :integer
#  rifle                 :integer
#  shotgun               :integer
#  SMG                   :integer
#  fist                  :integer
#  grapple               :integer
#  head                  :integer
#  kick                  :integer
#  melee                 :integer
#  art                   :text
#  craft                 :text
#  other_language        :text
#  pilot                 :text
#  other                 :text
#  character_id          :integer
#  created_at            :datetime
#  updated_at            :datetime
#  occupation_skills     :string
#

require 'rails_helper'

describe Coc::SkillSet do
  fixtures :skill_sets

  context 'skill set has points' do
    it '*_val methods add default values to base' do
      skill_sets(:one).accounting_val.should == 51
      skill_sets(:one).anthropology_val.should == 41
      skill_sets(:one).climb_val.should == 70
    end
  end

  context 'skill set has no points' do
    it '*_val methods returns base values' do
      skill_sets(:one).archaeology_val.should == 1
      skill_sets(:one).credit_rating_val.should == 15
    end
  end

  context 'sub categories' do
    it 'returns a hash of category with value' do
      skill_sets(:one).art_hash.should == { 'Dance' => '15', 'Sculpting' => '5' }
    end

    it '*_val returns a hash of sub categories to total skill value' do
      skill_sets(:one).art_val.should == { 'Dance' => 20, 'Sculpting' => 10 }
    end

    it '*_val? x returns if there is a value for the xth number' do
      skill_sets(:one).art_val?( 0 ).should == true
      skill_sets(:one).art_val?( 1 ).should == true
      skill_sets(:one).craft_val?( 0 ).should == false
      skill_sets(:one).craft_val?( 1 ).should == false
    end
  end
end
