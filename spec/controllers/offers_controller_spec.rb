require 'spec_helper'

describe OffersController do
    before do
      @attributes = {
        format: 'json',
        appid: '157',
        uid: 'player1',
        ip: '109.235.143.113',
        locale: 'de',
        device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
        timestamp: Time.now.to_i,
        offer_types: 112,
        pub0: '',
        page: ''
      }
    end

  describe "GET 'index'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', offer: @attributes
      response.should be_success
    end
    it 'has sp response headers' do
      get 'show', offer: @attributes
      expect(response).to include('x-sponsorpay-response-code')
      expect(response).to include('x-sponsorpay-response-signature')
    end
  end

end
