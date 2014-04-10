# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parapets/railties/version'

Gem::Specification.new do |spec|
  spec.name          = "parapets-railties"
  spec.platform      = Gem::Platform::RUBY
  spec.version       = Parapets::Railties::Version::STRING
  spec.authors       = ["Seba Gamboa"]
  spec.email         = ["me@sagmor.com"]
  spec.summary       = %q{Railties addons to customize some Rails defaults}
  spec.description   = %q{Adds custom application defaults, router behaviours and controller types among other things.}
  spec.homepage      = "https://github.com/parapets/parapets-railties"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", ">= 1.3", "< 2.0"
  spec.add_dependency "railties", "~> 4.1.0"
  spec.add_dependency "interactor", "~> 2.1.0"
  spec.add_dependency "active_model_serializers", "~> 0.8.1"

  spec.add_development_dependency "rspec", '3.0.0.beta2'
end
