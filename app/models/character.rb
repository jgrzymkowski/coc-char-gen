class Character < ActiveRecord::Base
  attr_accessible :investigator_name, :first_name, :last_name, :occupation, :degrees, :birthplace, :gender, :age
  has_one :characteristic_set

  validates :investigator_name, :first_name, :last_name, :occupation, :birthplace, :gender, :age, presence: true
end