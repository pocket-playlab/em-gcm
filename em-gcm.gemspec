$:.push File.expand_path('../lib', __FILE__)
require 'em-gcm/version'

Gem::Specification.new do |s|
  s.name        = 'em-gcm'
  s.version     = EventMachine::GCM::VERSION
  s.authors     = ['Ariel Zavala']
  s.email       = ['arielo.zavala@gmail.com']
  s.summary     = %q{EventMachine based Google Cloud Messaging}

  s.rubyforge_project = 'em-gcm'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'eventmachine', '~> 1.0'
  s.add_runtime_dependency 'em-http-request', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.12'
end
