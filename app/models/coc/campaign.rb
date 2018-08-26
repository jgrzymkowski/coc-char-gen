# == Schema Information
#
# Table name: coc_campaigns
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  owner_id   :integer
#

class Coc::Campaign < ActiveRecord::Base
  include SoftDeletable

  belongs_to :owner, class_name: User.name

  has_many :coc_characters, class_name: 'Coc::Character'
  alias :characters :coc_characters

  has_many :users, through: :coc_characters

  default_scope { where(deleted_at: nil) }
end
