require 'spec_helper'

describe CharacteristicSet do
  describe '#initialize' do
    it 'does not raise an error with valid modifiers' do
      options = { strength: -1, intelligence: 2, size: -1, age: 50 }
      CharacteristicSet.new options
    end

    it 'raises an error with invalid modifiers' do
      options = { strength: -2, intelligence: 1, age: 50 }
      lambda do
        CharacteristicSet.new options
      end.should raise_error
    end

    it 'raises with nil age' do
      options = { strength: -1, intelligence: 1}
      lambda do
        CharacteristicSet.new options
      end.should raise_error
    end

    it 'has a minimum education of age + 6' do
      RandomGenerators.stub( :generate_3d6_3_stat ).and_return 50
      cs = CharacteristicSet.new( age: 18 )
      puts cs.errors.inspect
      puts (cs.methods - Object.methods).inspect
      CharacteristicSet.new( age: 18 ).education.should == 12
    end

    it 'adds a bonus to education for old people' do
      RandomGenerators.stub( :generate_3d6_3_stat ).and_return 12
      CharacteristicSet.new( age: 58 ).education.should == 17
      CharacteristicSet.new( age: 42 ).education.should == 15
    end
  end
end