# frozen_string_literal: true

module AbsorbApi
  class Api
    attr_reader :connection, :token

    def initialize
      @token = AbsorbApi::Authorize.new.token

      @connection ||= Faraday.new(url: AbsorbApi.configuration.url, parallel_manager: Typhoeus::Hydra.new(max_concurrency: 200)) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter :typhoeus
        faraday.headers = { "Authorization" => @token }
      end
    end
  end
end
