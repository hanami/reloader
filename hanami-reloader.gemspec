# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hanami/reloader/version"

Gem::Specification.new do |spec|
  spec.name          = "hanami-reloader"
  spec.version       = Hanami::Reloader::VERSION
  spec.authors       = ["Luca Guidi"]
  spec.email         = ["me@lucaguidi.com"]

  spec.summary       = "Hanami reloader"
  spec.description   = "Code reloading for Hanami"
  spec.homepage      = "http://hanamirb.org"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.3.0"

  spec.files         = `git ls-files -- lib/* CHANGELOG.md LICENSE.md README.md hanami-utils.gemspec`.split($/)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.add_dependency "hanami",     "~> 1.3"
  spec.add_dependency "guard-rack", "~> 2.2"

  spec.add_development_dependency "bundler", ">= 1.6", "< 3"
  spec.add_development_dependency "rake",    "~> 12.0"
  spec.add_development_dependency "rspec",   "~> 3.7"
end
