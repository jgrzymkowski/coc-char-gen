# == Schema Information
#
# Table name: campaigns
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :owners, class_name: User.name, join_table: :campaigns_owners

  has_many :characters

  def members
    (owners.to_a + users.to_a).uniq
  end
end
