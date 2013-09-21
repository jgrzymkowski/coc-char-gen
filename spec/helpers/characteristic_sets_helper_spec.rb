require 'spec_helper'

describe CharacteristicSetsHelper do
  class DummyCharacteristicSetsHelper; include CharacteristicSetsHelper end

  let( :arranged ) { [ :constitution, :education, :dexterity, :strength, :power, :intelligence, :size, :appearance ] }

  before :each do
    RandomGenerators.stub( :generate_d6_stat ).exactly(5).
        times.and_return 8, 10, 12, 14, 16
    RandomGenerators.stub( :generate_d6_6_stat ).exactly(2).
        times.and_return 9, 11
    RandomGenerators.stub( :generate_3d6_3_stat ).and_return 13
  end

  subject { DummyCharacteristicSetsHelper.new }
  describe '#generate_random_stats' do
    it 'assigns the values in order' do
      subject.generate_random_stats.
          should eql(
                       {
                           strength: 8,
                           dexterity: 10,
                           power: 12,
                           intelligence: 14,
                           appearance: 16,
                           constitution: 9,
                           size: 11,
                           education: 13
                       } )
    end
  end

  describe '#generate_arranged_stats' do
    it 'assigns the values in order' do
      subject.generate_arranged_stats( arranged ).
          should eql(
                       {
                           constitution: 16,
                           education: 14,
                           dexterity: 13,
                           strength: 12,
                           power: 11,
                           intelligence: 10,
                           size: 9,
                           appearance: 8
                       } )
    end
  end
end
