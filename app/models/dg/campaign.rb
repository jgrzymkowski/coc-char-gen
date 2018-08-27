# == Schema Information
#
# Table name: dg_campaigns
#
#  id         :integer          not null, primary key
#  name       :string
#  deleted_at :datetime
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Dg::Campaign < ActiveRecord::Base
  include SoftDeletable

  belongs_to :owner, class_name: User.name

  has_many :dg_characters, class_name: 'Dg::Character'
  alias :characters :dg_characters

  has_many :users, through: :dg_characters

  default_scope { where(deleted_at: nil) }

  def game_system
    GameSystem.find('delta-green')
  end
end

