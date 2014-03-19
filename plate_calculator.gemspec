# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plate_calculator/version'

Gem::Specification.new do |spec|
  spec.name          = 'plate_calculator'
  spec.version       = PlateCalculator::VERSION
  spec.authors       = ['Michael Berkowitz']
  spec.email         = ['michael.berkowitz@gmail.com']
  spec.description   = %q{Find the best combination of weight plates for your target weight, based on barbell weight and plate availability.}
  spec.summary       = %q{Calculator for barbell weight plates.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
