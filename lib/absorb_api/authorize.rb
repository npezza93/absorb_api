# frozen_string_literal: true

module AbsorbApi
  class Authorize
    attr_reader :token

    def initialize
      @token ||= connection.post do |req|
        req.url "Authenticate", payload
        req.headers["Content-Type"] = "application/json"
        req.headers["accept"] = "json"
      end.body.delete('\\"')
    end

    private

    def connection
      @connection ||= Faraday.new(url: AbsorbApi.configuration.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter :typhoeus
      end
    end

    def payload
      {
        username: AbsorbApi.configuration.absorbuser,
        password: AbsorbApi.configuration.absorbpass,
        privateKey: AbsorbApi.configuration.absorbkey
      }
    end
  end
end
