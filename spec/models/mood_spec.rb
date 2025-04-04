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
require 'rails_helper'

RSpec.describe Mood, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
