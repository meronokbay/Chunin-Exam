require 'rails_helper'

RSpec.describe 'CreateShortenedUrls', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'when not logged in' do
    it 'shortens a valid link' do
      full_url = 'https://example.com'
      visit root_url
      fill_in 'url[full_url]', with: full_url
      click_link_or_button 'Shorten'
      expect(page).to have_text('Url shortened successfully.')
    end

    it "doesn't shorten an invalid link" do
      full_url = 'http://e'
      visit root_url
      fill_in 'url[full_url]', with: full_url
      click_link_or_button 'Shorten'
      expect(page).to have_text('Full url is invalid')
    end
  end

  describe 'when logged in' do
    before(:example) do
      @user = User.create(email: 'test@example.com', password: '123456')
    end

    it 'shortens a valid link' do
      full_url = 'https://example.com'
      sign_in @user
      visit root_url
      click_link_or_button 'Shorten a Link'
      fill_in 'url[full_url]', with: full_url
      click_link_or_button 'Shorten'
      expect(page).to have_text('Url shortened successfully.')
    end

    it "doesn't shorten an invalid link" do
      full_url = 'http://e'
      sign_in @user
      visit root_url
      click_link_or_button 'Shorten a Link'
      fill_in 'url[full_url]', with: full_url
      click_link_or_button 'Shorten'
      expect(page).to have_text('Full url is invalid')
    end
  end
end
