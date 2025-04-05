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

  # validate :only_one_mood_a_day

  validates :emotion, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  validates :comment, length: { maximum: 500 }, allow_blank: true
  # validates :ip_address, format: { with: Resolv::IPv4::Regex, message: "Must be valid IP address" }, presence: true, uniqueness: true


  # private

  # def only_one_mood_a_day
  #   today_mood = user_ip.moods.where("DATE(created_at) = ?", Date.today)

  #   byebug
  #   if today_mood.exists?
  #     errors.add(:base, "You can only submit one mood per day.")
  #   end
  # end
  #
  def self.is_submitted_today?(user_ip)
    mood = user_ip.moods.last

    mood.nil? || mood.created_at < Time.current.beginning_of_day
  end
end
