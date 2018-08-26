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

require 'rails_helper'

RSpec.describe Coc::Campaign, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
