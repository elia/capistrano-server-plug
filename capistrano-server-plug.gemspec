# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/server/plug/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-server-plug'
  spec.version       = Capistrano::Server::Plug::VERSION
  spec.authors       = ['Elia Schito']
  spec.email         = ['elia@schito.me']
  spec.description   = %q{Make the deploy server a simple capistrano setting}
  spec.summary       = %q{Make the deploy server a simple capistrano setting}
  spec.homepage      = 'https://github.com/elia/capistrano-server-plug#readme'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'capistrano', ['~> 2.15', '>= 2.15.5']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
