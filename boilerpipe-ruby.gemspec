# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boilerpipe/version'

Gem::Specification.new do |spec|
  spec.name          = 'boilerpipe-ruby'
  spec.version       = Boilerpipe::VERSION
  spec.authors       = ['Gregory Ostermayr']
  spec.email         = ['<gregory.ostermayr@gmail.com>']
  spec.license       = 'Apache 2.0'

  spec.summary       = %q{A pure ruby implemenation of the boilerpipe algorithm}
  spec.description   = %q{A pure ruby implementation of the boilerpipe algorithm}
  spec.homepage      = 'https://github.com/gregors/boilerpipe-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rickshaw', '~> 0.4.0'
  spec.add_development_dependency 'cane', '~> 3.0.0'
  spec.add_runtime_dependency 'nokogiri', '>= 1.6.6.2'
end
