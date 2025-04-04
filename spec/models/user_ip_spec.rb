# == Schema Information
#
# Table name: user_ips
#
#  id         :bigint           not null, primary key
#  ip_address :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_ips_on_ip_address  (ip_address) UNIQUE
#
require 'rails_helper'

RSpec.describe UserIp, type: :model do
  let(:user_ip) { create(:user_ip) }
  let(:invalid_user_ip_nil) { build(:user_ip, ip_address: nil) }
  let(:invalid_user_ip) { build(:user_ip, ip_address: '1.2.3.4.5') }

  it 'is valid ip address' do
    expect(user_ip).to be_valid
  end

  it 'is invalid ip address' do
    expect(invalid_user_ip_nil).to_not be_valid
    expect(invalid_user_ip_nil.errors[:ip_address]).to include('Must be valid IP address')

    expect(invalid_user_ip).to_not be_valid
    expect(invalid_user_ip.errors[:ip_address]).to include('Must be valid IP address')
  end
end
