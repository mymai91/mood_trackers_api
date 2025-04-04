# == Schema Information
#
# Table name: moods
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  emotion    :string           default("pretty_good"), not null
#  ip_address :string(255)
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "resolv"
class Mood < ApplicationRecord
  enum :emotion, { not_good_at_all: "not_good_at_all", a_bit_meh: "a_bit_meh", pretty_good: "pretty_good", felling_greate: "felling_greate" }

  validates :emotion, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  validates :comment, length: { maximum: 500 }, allow_blank: true
  validates :ip_address, format: { with: Resolv::IPv4::Regex, message: "Must be valid IP address" }, presence: true, uniqueness: true
end
