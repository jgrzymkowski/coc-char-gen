require 'spec_helper'

describe SkillSet do
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