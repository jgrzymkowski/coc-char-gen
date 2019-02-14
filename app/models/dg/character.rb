# == Schema Information
#
# Table name: dg_characters
#
#  id                                 :integer          not null, primary key
#  first_name                         :string
#  last_name                          :string
#  alias                              :string
#  profession                         :string
#  employer                           :string
#  nationality                        :string
#  gender                             :string
#  date_of_birth                      :date
#  education_and_occupational_history :string
#  user_id                            :integer
#  campaign_id                        :integer
#  created_at                         :datetime
#  updated_at                         :datetime
#

class Dg::Character < ActiveRecord::Base
  include SoftDeletable

  #has_one :characteristic_set
  #has_one :skill_set

  belongs_to :user
  belongs_to :campaign, class_name: 'Dg::Campaign'

  has_one :dg_statistic_set, class_name: 'Dg::StatisticSet'
  alias :statistic_set :dg_statistic_set

  has_one :dg_skill_set, class_name: 'Dg::SkillSet'
  alias :skill_set :dg_skill_set

  validates :first_name, :last_name, presence: true

  scope :belonging_to, -> (user) { where(user: user) }
  scope :not_belonging_to, -> (user) { where.not(user: user) }

  def age
    now = Time.now.utc.to_date
    now.year -
      date_of_birth.year -
      ((now.month > date_of_birth.month ||
        (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ?
    0 : 1)
  end

  def display_age_and_dob
    "#{age} (#{date_of_birth.strftime('%m-%d-%Y')})"
  end

  def display_name
    @display_name = [first_name, last_name].compact.join(' ')
    !self.alias.blank? ? "#{@display_name} (#{self.alias})" : @display_name
  end
end
