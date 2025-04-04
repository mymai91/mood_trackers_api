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
FactoryBot.define do
  factory :user_ip do
    ip_address { "172.0.0.1" }
  end
end
