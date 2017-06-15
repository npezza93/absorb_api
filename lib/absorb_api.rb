# frozen_string_literal: true

require "faraday"
require "typhoeus/adapters/faraday"
require "json"
require "faraday_middleware"
require "active_support/all"
require "active_model"

require "absorb_api/relations"
require "absorb_api/create"
require "absorb_api/where"
require "absorb_api/collection"

require "absorb_api/version"
require "absorb_api/configuration"
require "absorb_api/record"
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
require "absorb_api/authorize"
require "absorb_api/api"

module AbsorbApi
  class ResourceNotFound < StandardError; end
  class RouteNotFound < StandardError; end
  class ValidationError < StandardError; end

  def self.token
    @authorization ||= Authorize.new

    @authorization.token
  end
end
