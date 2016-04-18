module AbsorbApi
  class Authorize
    attr_reader :token

    def initialize
      @token ||= Faraday.new(url: AbsorbApi.configuration.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter :typhoeus
      end.post do |req|
        req.url 'Authenticate', username: AbsorbApi.configuration.absorbuser, password: AbsorbApi.configuration.absorbpass, privateKey: AbsorbApi.configuration.absorbkey
        req.headers['Content-Type'] = 'application/json'
        req.headers['accept'] = 'json'
      end.body.delete('\\"')
    end
  end
end
