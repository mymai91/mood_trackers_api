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
require 'rails_helper'

RSpec.describe Mood, type: :model do
  let (:user_ip) { create(:user_ip) }
  let (:mood) { create(:mood, user_ip: user_ip) }
  let(:invalid_mood) { build(:mood, emotion: nil) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(mood).to be_valid
    end

    it "it is invalid if emotion is nil" do
      expect(invalid_mood).to_not be_valid
      expect(invalid_mood.errors[:emotion]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "belongs to user_ip" do
      expect(mood.user_ip).to be_a(UserIp)
    end

    it "only allow 1 mood from the same ip address per day" do
      user_ip = create(:user_ip)

      first_mood = create(:mood, user_ip: user_ip, created_at: Date.today)

      expect(first_mood).to be_valid
    end
  end
end
