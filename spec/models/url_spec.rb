require 'rails_helper'

RSpec.describe Url, type: :model do
  it "doesn't validate url if full_url isn't present" do
    url = Url.create
    expect(url.valid?).to be false
  end

  it "doesn't validate url if full_url isn't a proper url string" do
    url = Url.create(full_url: 'example')
    expect(url.valid?).to be false
  end

  it "doesn't validate url if full_url doesn't have a schema" do
    url = Url.create(full_url: 'example.com')
    expect(url.valid?).to be false
  end

  it "doesn't validate url if full_url has an invalid schema" do
    url = Url.create(full_url: 'fff://example.com')
    expect(url.valid?).to be false
  end

  it 'validates url if full_url is present and has a valid schema' do
    url = Url.create(full_url: 'https://example.com')
    expect(url.valid?).to be true
  end
end
