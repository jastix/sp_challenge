require 'spec_helper'

describe Offer do
    before do
      @attributes = {
        format: 'json',
        appid: '157',
        uid: 'player1',
        ip: '109.235.143.113',
        locale: 'de',
        device_id: '2b6f0cc904d137be2 e1730235f5664094b 831186',
        timestamp: 1312471066,
        offer_types: 112,
        hashkey: '211a7f41267ad7a52bbc6655010560d8bb79c91d'
      }
    end

  describe '.generate_hash' do
  end

  describe '.find' do
  end

end
