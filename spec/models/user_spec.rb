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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#display_name' do
    it 'displays names nicely' do
      user = User.new(first_name: 'Howard', last_name: 'Lovecraft')
      expect(user.display_name).to eq('Howard Lovecraft')
    end

    context 'no last name' do
      it 'displays names nicely' do
        user = User.new(first_name: 'Howard')
        expect(user.display_name).to eq('Howard')

        user = User.new(first_name: 'Howard', last_name: '')
        expect(user.display_name).to eq('Howard')
      end
    end

    context 'no first name' do
      it 'displays names nicely' do
        user = User.new(last_name: 'Lovecraft')
        expect(user.display_name).to eq('Lovecraft')

        user = User.new(last_name: 'Lovecraft')
        expect(user.display_name).to eq('Lovecraft')
      end
    end
  end
end
