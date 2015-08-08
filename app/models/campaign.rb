class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :owners, class_name: User.name, join_table: :campaigns_owners

  def members
    (owners.to_a + users.to_a).uniq
  end
end
