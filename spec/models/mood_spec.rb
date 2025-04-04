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
  let(:mood) { create(:mood) }
  let(:invalid_mood) { build(:mood, emotion: nil) }
  let(:invalid_ip_address) { build(:mood, ip_address: "invalid_ip") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(mood).to be_valid
    end

    it "it is invalid if emotion is nil" do
      expect(invalid_mood).to_not be_valid
      expect(invalid_mood.errors[:emotion]).to include("can't be blank")
    end

    it "it is invalid if ip_address is invalid" do
      expect(invalid_ip_address).to_not be_valid
      expect(invalid_ip_address.errors[:ip_address]).to include("Must be valid IP address")
    end
  end
end
