require 'spec_helper'

feature 'List offers from the API', %q{
  As a guest
  I want to visit the homepage and fill in a form with valid data
  so that i can retrieve offers from the API.
} do

  scenario 'Retrieve offers from the API' do
    visit root_path
    fill_in 'offer_uid', with: 'player1'
    fill_in 'offer_pub0', with: 'campaign2'
    fill_in 'offer_page', with: '2'
    click_button 'Submit'
    expect(page).to have_content 'Current offers'
  end
end
