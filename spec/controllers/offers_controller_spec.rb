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
      expect(response).to be_success
    end

  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', offer: @attributes
      expect(response).to be_success
    end

    context 'with valid response' do
      it 'populates @offers with original code' do
        offer = mock_model(Offer)
        offer.stub!(:find).and_return({ code: 'NO_CONTENT'} )
        get 'show', offer: @attributes
        expect(assigns[:offers]).to_not be_empty
      end
    end

    context 'with malicious response' do
      it 'populates @offers with code Malicious_Request' do
        offer = mock_model(Offer)
        Offer.stub!(:valid_signature?) { false }
        get 'show', offer: @attributes
        expect(assigns[:offers]).to_not be_empty
        expect(assigns[:offers][:code]).to eql 'Malicious_Request'
      end
    end
  end

end
