# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pva/version'

Gem::Specification.new do |spec|
  spec.name          = "pva"
  spec.version       = Pva::VERSION
  spec.authors       = ["David Rueck"]
  spec.email         = ["drueck@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  end

  spec.summary       = "A Command Line Interface for the Portland Volleyball Association"
  spec.description   = "See schedules, standings, and scores for your teams from the confort of your shell."
  spec.homepage      = "https://github.com/drueck/pva"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "chronic"
end
