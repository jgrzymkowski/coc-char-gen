# == Schema Information
#
# Table name: characters
#
#  id                   :integer          not null, primary key
#  first_name           :string
#  last_name            :string
#  occupation           :string
#  degrees              :string
#  birthplace           :string
#  gender               :string
#  age                  :integer
#  created_at           :datetime
#  updated_at           :datetime
#  weapon_ids           :string
#  residence            :string
#  personal_description :string
#  family_and_friends   :text
#  episodes_of_insanity :string
#  wounds_and_injuries  :string
#  marks_and_scars      :string
#  history              :text
#  income               :string
#  cash                 :string
#  savings              :string
#  property             :string
#  real_estate          :string
#  user_id              :integer
#

class Coc::Character < ActiveRecord::Base
  include Coc::WeaponsHelper
  include SoftDeletable

  has_one :characteristic_set
  has_one :skill_set

  belongs_to :user
  belongs_to :campaign

  validates :first_name, :last_name, :occupation, :birthplace, :gender, :age, presence: true

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
