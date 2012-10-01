# -*- encoding: utf-8 -*-
require File.expand_path('../lib/value_object/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Harry Garrood"]
  gem.email         = ["hdgarrood@gmail.com"]
  gem.description   = %q{A tiny gem for value objects.}
  gem.summary       = %q{A gem which gives you a class which you can subclass to easily create immutable value objects.}
  gem.homepage      = "https://github.com/hdgarrood/value_object"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "value_object"
  gem.require_paths = ["lib"]
  gem.version       = ValueObject::VERSION

  gem.add_dependency 'activesupport'
  gem.add_development_dependency 'simplecov'
end
