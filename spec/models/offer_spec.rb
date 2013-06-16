require 'spec_helper'

describe Offer do
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

  describe '.find' do
    context "With valid response" do
      it 'returns JSON hash' do
        Offer.stub!(:valid_signature?) { true }
        resp = Offer.find(@attributes)
        expect(resp).to be_a(Hash)
        expect(resp).to have_key('code')
      end
    end

    context 'With malicious response' do
      it 'returns hash with code Malicious_Response' do
        Offer.stub!(:valid_signature?) { false }
        resp = Offer.find(@attributes)
        expect(resp).to be_a(Hash)
        expect(resp).to have_key(:code)
        expect(resp[:code]).to eql 'Malicious_Response'
      end
    end
  end

end
