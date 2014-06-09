# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'setty/version'

Gem::Specification.new do |spec|
  spec.name          = "setty"
  spec.version       = Setty::VERSION
  spec.authors       = ["Radoslav Stankov"]
  spec.email         = ["rstankov@gmail.com"]
  spec.description   = %q{Mini application configuration for Rails projects.}
  spec.summary       = %q{Geneartes object hierarchy based on YAML files}
  spec.homepage      = "https://github.com/rstankov/setty"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '3.0'
  spec.add_development_dependency 'rspec-mocks', '3.0'
  spec.add_development_dependency 'coveralls'
end

