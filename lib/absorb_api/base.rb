module AbsorbApi
  class Base
    def self.authorize
      @authorize ||= Faraday.new(:url => AbsorbApi.configuration.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter :typhoeus
      end.post do |req|
        req.url 'Authenticate', { username: AbsorbApi.configuration.absorbuser, password: AbsorbApi.configuration.absorbpass, privateKey: AbsorbApi.configuration.absorbkey }
        req.headers['Content-Type'] = 'application/json'
        req.headers["accept"] = "json"
      end.body.delete('\\"')
    end

    def self.api
      @api ||= Faraday.new(:url => AbsorbApi.configuration.url, :parallel_manager => Typhoeus::Hydra.new(:max_concurrency => 200)) do |faraday|
        faraday.request :json
        faraday.response :json, :content_type => /\bjson$/
        faraday.adapter :typhoeus
        faraday.headers = {"Authorization" => authorize }
      end
    end
  end
end
