class Offer
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :uid, :pub0, :page, :format, :appid, :locale,
    :device_id, :timestamp, :offer_types, :hashkey

  validates :uid, :format, :appid, :locale, :device_id, :timestamp,
            :hashkey, presence: true

  def initialize(attributes = {})
    self.uid = attributes[:uid]
    self.pub0 = attributes[:pub0]
    self.page = attributes[:page]
    self.format = attributes[:format]
    self.appid = attributes[:appid]
    self.locale = attributes[:locale]
    self.device_id = attributes[:device_id]
    # self.timestamp = Time.now.to_i
    self.offer_types = attributes[:offer_types]
    # self.hashkey = generate_hash(attributes.tap { |attr| attr.delete(:format) })

  end

  def find(attributes)
    self.api_connection.get do |req|
      req.url 'offers.' +  attributes[:format] || 'json'
      req.params['appid'] = attributes[:appid] || 157
      req.params['uid'] = attributes[:uid]
      req.params['ip'] = attributes[:ip]
      # TODO: continue with attributes
    end
  end

  private

  def api_connection
    Faraday.new(url: "http://api.sponsorpay.com/feed/v1/") do |faraday|
      faraday.response :logger
      faraday.use Faraday::Adapter::NetHttp
      faraday.use FaradayMiddleware::ParseJson
    end
  end

  def generate_hash(attributes)
    attributes.keys.sort!
    Digest::SHA1.hexdigest(URI.encode_www_form(attributes)) + ENV['api_key']
  end
end
