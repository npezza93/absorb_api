# frozen_string_literal: true

module AbsorbApi
  class Api
    attr_writer :connection

    delegate :get, :put, :patch, :post, :delete, to: :connection

    def connection
      @connection ||= Faraday.new(
        url: AbsorbApi.configuration.url,
        parallel_manager: Typhoeus::Hydra.new(max_concurrency: 200)
      ) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter :typhoeus
        faraday.headers = { "Authorization" => AbsorbApi.token }
      end
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def patch(path, params = {})
      request(:patch, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    private

    def request(http_method, path, params)
      response = connection.send(http_method, path, params)

      raise RouteNotFound    if [404, 405].include?(response.status)
      raise ResourceNotFound if [400].include?(response.status)
      raise ValidationError  if [500].include?(response.status)

      response.body
    end
  end
end
