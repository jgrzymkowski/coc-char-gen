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

  has_many :campaign_users
  has_many :owned_coc_campaigns, through: :campaign_users, source: 'campaign', source_type: 'Coc::Campaign'
  has_many :owned_dg_campaigns, through: :campaign_users, source: 'campaign', source_type: 'Dg::Campaign'

  has_many :coc_characters, class_name: "Coc::Character"
  has_many :coc_campaigns, through: :coc_characters, source: :campaign

  has_many :dg_characters, class_name: "Dg::Character"
  has_many :dg_campaigns, through: :dg_characters, source: :campaign

  def display_name
    if first_name.blank?
      last_name
    elsif last_name.blank?
      first_name
    else
      [first_name, last_name].join(' ')
    end
  end

  def all_campaigns
    (campaigns + owned_campaigns).uniq
  end
end
