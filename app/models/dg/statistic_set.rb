# == Schema Information
#
# Table name: dg_statistic_sets
#
#  id           :integer          not null, primary key
#  strength     :integer
#  constitution :integer
#  dexterity    :integer
#  intelligence :integer
#  power        :integer
#  charisma     :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Dg::StatisticSet < ActiveRecord::Base
  belongs_to :character, class_name: 'Dg::Character'

  def hit_points
    return nil unless strength && constitution
    ((strength + constitution)/2).ceil
  end

  def willpower
    power
  end

  def sanity
    return nil unless power
    power * 5
  end

  def breaking_point
    return nil unless sanity && power
    sanity - power
  end
end
