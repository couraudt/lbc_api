# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lbc_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'lbc_api'
  spec.version       = LbcApi::VERSION
  spec.authors       = ['Thibault Couraud']
  spec.email         = ['contact@sweetdub.com']
  spec.summary       = %q{Leboncoin.fr Ruby API wrapper.}
  spec.description   = %q{Manage & search classified ads, create users accounts.}
  spec.homepage      = 'https://github.com/sweetdub/lbc_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.2'
  spec.add_dependency 'mechanize', '~> 2.7'
end
