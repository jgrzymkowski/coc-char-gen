# == Schema Information
#
# Table name: coc_characteristic_sets
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

require 'random_generator'

class Coc::CharacteristicSet < ActiveRecord::Base
  belongs_to :character

  def sanity
    [power * 5, 99 - cthulhu_mythos].min
  end

  def idea
    intelligence * 5
  end

  def luck
    power * 5
  end

  def know
    education * 5
  end

  def hit_points
    (constitution + size) / 2
  end

  def magic_points
    power
  end

  def cthulhu_mythos
    0
  end

  def damage_bonus
    case strength + size
      when 2..12 then '-1D6'
      when 13..16 then '-1D4'
      when 17..24 then '+0'
      when 25..32 then '+1D4'
      when 33..40 then '+1D6'
      else "+#{2 + ( strength + size - 41 ) / 16}D6"
    end
  end

  def occupation_skill_points
    education * 20
  end

  def personal_interest_points
    intelligence * 10
  end
end
