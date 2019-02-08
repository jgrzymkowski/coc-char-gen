# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :text
#  last_name              :text
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :campaign_users, class_name: 'CampaignUsers'

  has_many :owned_coc_campaigns, class_name: 'Coc::Campaign', foreign_key: :owner_id
  has_many :owned_dg_campaigns, class_name: 'Dg::Campaign', foreign_key: :owner_id

  has_many :coc_characters, class_name: "Coc::Character"
  has_many :coc_campaigns, through: :campaign_users, source: 'campaign', source_type: 'Coc::Campaign'

  has_many :dg_characters, class_name: "Dg::Character"
  has_many :dg_campaigns, through: :campaign_users, source: 'campaign', source_type: 'Dg::Campaign'

  def display_name
    if first_name.blank?
      last_name
    elsif last_name.blank?
      first_name
    else
      [first_name, last_name].join(' ')
    end
  end
end
