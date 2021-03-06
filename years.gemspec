# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'years/version'

Gem::Specification.new do |spec|
  spec.name          = "years"
  spec.version       = Years::VERSION
  spec.authors       = ["Nigel Lowry"]
  spec.email         = ["nigel-lowry@ultra.eclipse.co.uk"]
  spec.summary       = %q{Small gem for showing year ranges.}
  spec.description   = %q{Small gem to create year ranges for copyright statements in Web pages.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "activesupport"
  spec.add_development_dependency "yard"
end
