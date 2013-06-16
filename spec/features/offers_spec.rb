require 'spec_helper'

feature 'List offers from the API', %q{
  As a guest
  I want to visit the homepage and fill in a form with valid data
  so that i can retrieve offers from the API.
} do

  scenario 'Retrieve no offers from the API' do
    visit root_path
    fill_in 'offer_uid', with: 'player1'
    click_button 'Submit'
    expect(page).to have_content 'Current offers'
    expect(page).to have_selector('div.no_offers', text: 'No offers')
  end

  scenario 'Retrive offers from the API' do
    data = {"code" => 'OK',
            "offers" => [
              { "title" => 'Tap fish',
                "thumbnail" => {
                  "lowres" => 'http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_60.png'
                    },
                 "payout" => '90'
              }, ]
            }
    Offer.stub!(:find).and_return(data)
    visit root_path
    fill_in 'offer_uid', with: 'player1'
    click_button 'Submit'
    expect(page).to have_selector('div.offer')
    expect(page).to have_selector('div.title')
    expect(page).to have_selector('div.payout')
    expect(page).to have_selector('div.thumbnail')
  end

end
