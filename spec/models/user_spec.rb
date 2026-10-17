require "rails_helper"

RSpec.describe User do
  subject(:user) { build(:user) }

  it { is_expected.to have_many(:identities).dependent(:destroy) }
  it { is_expected.to have_many(:sessions).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "normalizes email to lowercase without surrounding whitespace" do
    expect(described_class.new(email: "  Boon@Example.COM ").email).to eq("boon@example.com")
  end
end
