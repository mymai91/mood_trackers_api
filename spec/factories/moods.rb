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
FactoryBot.define do
  factory :mood do
    emotion { "pretty_good" }
    rating { 1 }
    comment { "Good" }
    association :user_ip
    created_at { Time.current }

    # Use time anchor is first day of month

    trait :created_yesterday do
      created_at { Time.current.beginning_of_month - 1.day }
      emotion { "not_good_at_all" }
      rating { 1 }
      comment { "Bad" }
    end

    trait :created_two_weeks_ago do
      created_at { Time.current.beginning_of_month - 2.weeks }
      emotion { "a_bit_meh" }
      rating { 3 }
      comment { "hum bit mehh" }
    end

    trait :created_last_month do
      created_at { Time.current.beginning_of_month - 1.month }
      emotion { "felling_great" }
      rating { 5 }
      comment { "Great" }
    end
  end
end
