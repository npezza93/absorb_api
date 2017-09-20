# frozen_string_literal: true

module AbsorbApi
  class Api
    attr_writer :connection

    delegate :get, :put, :patch, :post, :delete, to: :connection

    def connection
      Faraday.new(url: AbsorbApi.configuration.url) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
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
      ignore_resource_not_found = params.delete(:ignore_resource_not_found)
      response = connection.send(http_method, path, params)
      handle_errored_response(response, ignore_resource_not_found)

      if response.status == 401
        response = fetch_new_token_and_try_again(http_method, path, params)
        handle_errored_response(response, ignore_resource_not_found)
      end

      fetch_response_body(response, ignore_resource_not_found)
    end

    def fetch_new_token_and_try_again(http_method, path, params)
      AbsorbApi.authorization = nil
      connection.send(http_method, path, params)
    end

    def handle_errored_response(response, ignore_resource_not_found = false)
      unless ignore_resource_not_found
        raise RouteNotFound    if [404, 405].include?(response.status)
        raise ResourceNotFound if [400].include?(response.status)
      end

      raise ValidationError if [500].include?(response.status)
    end

    def fetch_response_body(response, ignore_resource_not_found = false)
      return response.body unless ignore_resource_not_found

      if [404, 405, 400].include?(response.status)
        []
      else
        response.body
      end
    end
  end
end
