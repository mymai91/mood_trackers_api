# == Schema Information
#
# Table name: moods
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  emotion    :string           default("pretty_good"), not null
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_ip_id :bigint           not null
#
# Indexes
#
#  index_moods_on_user_ip_id  (user_ip_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_ip_id => user_ips.id)
#

require "resolv"
class Mood < ApplicationRecord
  belongs_to :user_ip

  enum :emotion, { not_good_at_all: "not_good_at_all", a_bit_meh: "a_bit_meh", pretty_good: "pretty_good", felling_great: "felling_great" }

  validates :emotion, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  validates :comment, length: { maximum: 500 }, allow_blank: true

  def self.is_submitted_today?(user_ip)
    mood = user_ip.moods.last

    mood.nil? || mood.created_at < Time.current.beginning_of_day
  end
end
