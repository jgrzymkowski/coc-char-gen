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

require 'test_helper'

class CharacteristicSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test
end
