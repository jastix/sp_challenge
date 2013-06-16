class Offer
  extend ActiveModel::Naming

  attr_accessor :uid, :pub0, :page, :format, :appid, :locale,
    :device_id, :timestamp, :offer_types, :hashkey

  def self.find(attributes)
    response = self.perform_request(attributes)
    if self.valid_signature?(response)
      JSON.parse(response.body)
    else
      Rails.logger.warn "Malicious response: #{response.body}" 
      { code: 'Malicious_Request'}
    end
  end

  #######
  private
  #######

  def self.api_connection
    Faraday.new(url: "http://api.sponsorpay.com/feed/v1/") do |faraday|
      # faraday.response :logger # for debugging
      faraday.use Faraday::Adapter::NetHttp
    end
  end

  def self.perform_request(attributes)
    self.api_connection.get do |req|
      req.url 'offers.' +  attributes[:format]
      attributes.tap { |hs| hs.delete(:format) }.sort_by { |k, v| k }.each do |attr|
        req.params["#{attr[0]}"] = attr[1]
      end
      req.params['hashkey'] = self.generate_hash(attributes)
    end
  end

  def self.valid_signature?(response)
    req_hash = Digest::SHA1.hexdigest(response.body + ENV['api_key']).downcase
    response['x-sponsorpay-response-signature'] == req_hash
  end

  def self.generate_hash(attributes)
    sorted_attrs = attributes.tap { |hs| hs.delete(:format) }.sort_by { |k, v| k }
    Digest::SHA1.hexdigest(URI.encode_www_form(sorted_attrs) + '&' + ENV['api_key']).downcase
  end
end
