class CampaignUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign, polymorphic: true
end
