require 'faraday'
require 'typhoeus/adapters/faraday'
require 'json'
require 'faraday_middleware'
require 'active_support/all'
require 'active_model'

require "absorb_api/orm"
require "absorb_api/relations"
require "absorb_api/collection"

require "absorb_api/version"
require "absorb_api/configuration"
require "absorb_api/base"
require "absorb_api/user"
require "absorb_api/course"
require "absorb_api/course_enrollment"
require "absorb_api/lesson_enrollment"
require "absorb_api/category"
require "absorb_api/certificate"
require "absorb_api/chapter"
require "absorb_api/curriculum"
require "absorb_api/department"
require "absorb_api/tag"
require "absorb_api/session_schedule"
require "absorb_api/role"
require "absorb_api/resource"
require "absorb_api/prerequisite"
require "absorb_api/lesson"

module AbsorbApi
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
