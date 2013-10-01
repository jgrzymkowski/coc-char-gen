require 'spec_helper'

describe SkillSetsHelper do

  describe '#table_title' do
    class DummyHelper;
      include SkillSetsHelper
      def initialize( char )
        @character = char
      end
    end

    context 'no character' do
      fixtures :characters
      fixtures :characteristic_sets

      it 'formats the skill title with base point' do
        subject = DummyHelper.new nil

        subject.table_title( :art ).should == 'Art (5%)'
        subject.table_title( :conceal ).should == 'Conceal (15%)'
        subject.table_title( :dodge ).should == 'Dodge (DEXx2%)'
        subject.table_title( :own_language ).should == 'Own Language (EDUx5%)'
        subject.table_title( :operate_heavy_machine).should == 'Operate Heavy Machine (1%)'
      end

      it 'formats the skill title with base point' do
        subject = DummyHelper.new characters(:one)

        subject.table_title( :art ).should == 'Art (5%)'
        subject.table_title( :conceal ).should == 'Conceal (15%)'
        subject.table_title( :dodge ).should == 'Dodge (18%)'
        subject.table_title( :own_language ).should == 'Own Language (75%)'
        subject.table_title( :operate_heavy_machine).should == 'Operate Heavy Machine (1%)'
      end
    end

  end

end