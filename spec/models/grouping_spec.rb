require 'rails_helper'

RSpec.describe Grouping, type: :model do
  before(:example) do
    @user = User.create(email: 'test@example.com', password: '123456')
    @url = @user.urls.create(full_url: 'http://example.com')
  end

  it "doesn't validate if user doesn't exist" do
    group = Grouping.new(url_id: @url.id)
    expect(group.valid?).to be false
  end

  it "doesn't validate if url doesn't exist" do
    group = Grouping.new(user_id: @user.id)
    expect(group.valid?).to be false
  end

  it 'validates if both url and user exist' do
    group = Grouping.new(user_id: @user.id, url_id: @url.id)
    expect(group.valid?).to be true
  end
end
