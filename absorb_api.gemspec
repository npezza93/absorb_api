# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'absorb_api/version'

Gem::Specification.new do |spec|
  spec.name          = "absorb_api"
  spec.version       = AbsorbApi::VERSION
  spec.authors       = ["npezza93"]
  spec.email         = ["npezza93@gmail.com"]

  spec.summary       = "API wrapper for Absorb LMS"
  spec.description   = "\"Absorb LMS is a powerful, flexible, and visually stunning software platform teamed with expert implementation and support to help you build the training programs your business needs. Whether your old LMS is slowing you down or you’ve outgrown your current training model, Absorb can help.
  \""
  spec.homepage      = "https://github.com/npezza93/absorb_api"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
