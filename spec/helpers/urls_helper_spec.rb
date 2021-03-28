require 'rails_helper'

RSpec.describe UrlsHelper, type: :helper do  
  context 'counts returned by visits_count' do
    before(:example) do
      @url = Url.create(full_url: 'http://example.com')
      @url.trackers.create(platform: 'linux')
      @url.trackers.create(platform: 'mac')
      @url.trackers.create(platform: 'windows')
    end

    it 'total count is 3' do
      expect(visits_count(@url)[:total]).to be 3
    end

    it 'linux count is 1' do
      expect(visits_count(@url)[:linux]).to be 1
    end

    it 'windows count is 1' do
      expect(visits_count(@url)[:windows]).to be 1
    end

    it 'android count is 0' do
      expect(visits_count(@url)[:android]).to be 0
    end

    it 'ios count is 0' do
      expect(visits_count(@url)[:ios]).to be 0
    end

    it 'other count is 1' do
      @url.trackers.create(platform: 'other')
      expect(visits_count(@url)[:other]).to be 1
    end
  end
end
