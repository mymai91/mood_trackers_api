class MoodSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  set_type :mood
  attributes :emotion, :comment, :rating, :created_at, :updated_at

  cache_options enabled: true, cache_length: 12.hours
end
