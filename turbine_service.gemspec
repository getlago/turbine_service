# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "turbine/version"

Gem::Specification.new do |spec|
  spec.name = "turbine_service"
  spec.version = Turbine::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 3.0.0"
  spec.authors = ["Vincent Pochet"]
  spec.email = ["vincent@getlago.com"]

  spec.summary = "Service layer library for your Ruby application"
  spec.homepage = "https://github.com/getlago/turbine-service"
  spec.license = "MIT"

  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = `git ls-files lib`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "debug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "standard"
end
