# == Schema Information
#
# Table name: characters
#
#  id                   :integer          not null, primary key
#  player_name          :string
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

require 'test_helper'

class Coc::CharacterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
