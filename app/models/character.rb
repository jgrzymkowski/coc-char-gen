class Character < ActiveRecord::Base
  attr_accessible :investigator_name, :first_name, :last_name, :occupation, :degrees, :birthplace, :gender, :age, :skill_occupation
  has_one :characteristic_set
  has_one :skill_set

  validates :investigator_name, :first_name, :last_name, :occupation, :birthplace, :gender, :age, presence: true

  def gender_read
    return 'Male' if @gender == 'm'
    return 'Female' if @gender == 'f'
    'Other'
  end
end