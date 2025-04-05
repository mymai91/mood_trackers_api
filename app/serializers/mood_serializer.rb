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
class MoodSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  set_type :mood
  attributes :emotion, :comment, :rating, :created_at, :updated_at

  cache_options enabled: true, cache_length: 12.hours
end
