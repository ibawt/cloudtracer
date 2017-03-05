# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'cloudtracer/version'

Gem::Specification.new do |s|
  s.name        = 'cloudtracer'
  s.version     = Cloudtracer::VERSION
  s.authors     = ['Ian Quick']
  s.email       = ['ian.quick@gmail.com']
  s.homepage    = 'https://github.com/ibawt/cloudtracer'
  s.summary     = 'Rails plugin for Google Cloudtrace'
  s.description = 'see summary'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_runtime_dependency 'rails', '>= 4'
  s.add_runtime_dependency 'googleauth'
  s.add_runtime_dependency 'google-api-client', '~> 0.9'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'timecop'
end
