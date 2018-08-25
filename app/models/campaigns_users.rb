class CampaignsUsers < ActiveRecord::Base
  has_many :users
  has_many :campaigns, polymorphic: true
end
