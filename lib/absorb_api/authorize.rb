# frozen_string_literal: true

module AbsorbApi
  class Authorize
    attr_accessor :created_at

    def initialize
      token
    end

    def expired?
      return true if created_at.blank?

      DateTime.now >= created_at + 4.hours
    end

    def token
      return @token unless expired?

      @token = ActiveSupport::JSON.decode(connection.post do |req|
        req.url "Authenticate"
        req.headers["Content-Type"] = "application/json"
        req.headers["accept"] = "json"
        req.body = payload.to_json
      end.body)
      @created_at = DateTime.now
    end

    private

    def connection
      Faraday.new(url: AbsorbApi.configuration.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def payload
      {
        "Username"   => AbsorbApi.configuration.absorbuser,
        "Password"   => AbsorbApi.configuration.absorbpass,
        "PrivateKey" => AbsorbApi.configuration.absorbkey
      }
    end
  end
end
