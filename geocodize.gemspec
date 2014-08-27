# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geocodize/version'

Gem::Specification.new do |spec|
  spec.name          = "geocodize"
  spec.version       = Geocodize::VERSION
  spec.authors       = ["jer"]
  spec.email         = ["deathbyjer@gmail.com"]
  spec.summary       = %q{Geocode addresses and zipcodes smartly using OpenStreetMap and others."}
# spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec"
  
  spec.add_runtime_dependency "rake"
  spec.add_runtime_dependency "redis"
end
