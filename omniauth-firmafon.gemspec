# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-firmafon/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-firmafon"
  s.version     = OmniAuth::Firmafon::VERSION
  s.authors     = ["Mikkel Malmberg"]
	s.email       = ["mm@firmafon.dk"]
  s.homepage    = "https://github.com/firmafon/omniauth-firmafon"
  s.summary     = %q{OmniAuth strategy for Firmafon}
  s.description = %q{OmniAuth strategy for Firmafon}
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.1.2'

  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rake'
end
