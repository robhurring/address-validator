# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'address_validator/version'

Gem::Specification.new do |gem|
  gem.name          = "address_validator"
  gem.version       = AddressValidator::VERSION
  gem.authors       = ["robhurring"]
  gem.email         = ["robhurring@gmail.com"]
  gem.description   = %q{UPS address validation gem}
  gem.summary       = %q{Simple address validator using the UPS address validation API}
  gem.homepage      = "https://github.com/robhurring/address-validator"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httparty', '>= 0.11.0'
  gem.add_dependency 'builder', '>= 3.0.4'
end
