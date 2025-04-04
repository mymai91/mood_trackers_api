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

require "resolv"

class UserIp < ApplicationRecord
  validates :ip_address, format: { with: Resolv::IPv4::Regex, message: "Must be valid IP address" }, presence: true, uniqueness: true
end
