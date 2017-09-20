# coding: utf-8
# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "absorb_api/version"

Gem::Specification.new do |spec|
  spec.name          = "absorb_api"
  spec.version       = AbsorbApi::VERSION
  spec.authors       = ["npezza"]
  spec.email         = ["npezza93@gmail.com"]

  spec.summary       = "API wrapper for Absorb LMS"
  spec.description   = "This gem provides a ruby wrapper for Absorb's Learning"\
    "Management System API."
  spec.homepage      = "https://github.com/npezza93/absorb_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "json"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop"
end
