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
FactoryBot.define do
  factory :mood do
    emotion { "pretty_good" }
    rating { 1 }
    comment { "Good" }
    ip_address { "127.0.0.1" }
  end
end
