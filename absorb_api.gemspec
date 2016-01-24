# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'absorb_api/version'

Gem::Specification.new do |spec|
  spec.name          = "absorb_api"
  spec.version       = AbsorbApi::VERSION
  spec.authors       = ["npezza"]
  spec.email         = ["npezza93@gmail.com"]

  spec.summary       = "API wrapper for Absorb LMS"
  spec.description   = "This gem provides a ruby wrapper for Absorb's Learning Management System API. \n\n"
  spec.homepage      = "https://github.com/npezza93/absorb_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
