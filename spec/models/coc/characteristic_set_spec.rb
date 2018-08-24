# == Schema Information
#
# Table name: characteristic_sets
#
#  id           :integer          not null, primary key
#  strength     :integer
#  dexterity    :integer
#  intelligence :integer
#  constitution :integer
#  appearance   :integer
#  power        :integer
#  size         :integer
#  education    :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

describe Coc::CharacteristicSet do
  describe '#initialize' do
    it 'does not raise an error with valid modifiers' do
      options = { strength: -1, intelligence: 2, size: -1 }
      Coc::CharacteristicSet.new options
    end

    it 'raises an error with invalid modifiers' do
      pending
      options = { strength: -2, intelligence: 1 }
      lambda do
        Coc::CharacteristicSet.new options
      end.should raise_error
    end

    it 'raises with nil age' do
      pending
      options = { strength: -1, intelligence: 1}
      lambda do
        Coc::CharacteristicSet.new options
      end.should raise_error
    end

    it 'has a minimum education of age + 6' do
      pending
      RandomGenerators.stub( :generate_3d6_3_stat ).and_return 50
      Coc::CharacteristicSet.new( age: 18 ).education.should == 12
    end

    it 'adds a bonus to education for old people' do
      pending
      RandomGenerators.stub( :generate_3d6_3_stat ).and_return 12
      Coc::CharacteristicSet.new( age: 58 ).education.should == 17
      Coc::CharacteristicSet.new( age: 42 ).education.should == 15
    end
  end
end
