require 'rails_helper'

RSpec.describe Tracker, type: :model do
  before(:example) do
    @url = Url.create(full_url: 'http://example.com')
  end

  it "doesn't validate if platform isn't present" do
    tracker = Tracker.new(url_id: @url.id)
    expect(tracker.valid?).to be false
  end

  it "doesn't validate if url_id isn't present" do
    tracker = Tracker.new(platform: 'linux')
    expect(tracker.valid?).to be false
  end

  it "doesn't validate if platform isn't included in the acceptable platforms" do
    tracker = Tracker.new(url_id: @url.id, platform: 'unicorn')
    expect(tracker.valid?).to be false
  end

  it 'validates if platform is acceptable' do
    tracker = Tracker.new(url_id: @url.id, platform: 'linux')
    expect(tracker.valid?).to be true
  end
end
