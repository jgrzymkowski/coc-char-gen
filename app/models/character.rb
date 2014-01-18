class Character < ActiveRecord::Base
  include WeaponsHelper

  attr_accessible :player_name, :first_name, :last_name, :occupation, :degrees, :birthplace, :gender, :age, :skill_occupation, :residence, :personal_description, :family_and_friends, :episodes_of_insanity, :wounds_and_injuries, :marks_and_scars, :history, :income, :cash, :savings, :property, :real_estate, :weapon_ids
  has_one :characteristic_set
  has_one :skill_set

  validates :player_name, :first_name, :last_name, :occupation, :birthplace, :gender, :age, presence: true

  validates_length_of :residence, :maximum => 33
  validates_length_of :personal_description, :maximum => 144
  validates_length_of :family_and_friends, :maximum => 199
  validates_length_of :episodes_of_insanity, :maximum => 106
  validates_length_of :wounds_and_injuries, :maximum => 144
  validates_length_of :marks_and_scars, :maximum => 144
  validates_length_of :history, :maximum => 925
  validates_length_of :income, :maximum => 36
  validates_length_of :cash, :maximum => 36
  validates_length_of :savings, :maximum => 45
  validates_length_of :property, :maximum => 139
  validates_length_of :real_estate, :maximum => 95

  def gender_read
    return 'Male' if @gender == 'm'
    return 'Female' if @gender == 'f'
    'Other'
  end

  def weapons
    (weapon_ids || '').split(',').map do |id|
      weapon_by_id( id.to_i )
    end
  end
end
