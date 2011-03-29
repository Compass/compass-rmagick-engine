# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "compass-rmagick-engine/version"

Gem::Specification.new do |s|
  s.name        = "compass-rmagick-engine"
  s.version     = Compass::Rmagick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scott Davis"]
  s.email       = ["jetviper21@gmail.com"]
  s.homepage    = "https://github.com/jetviper21/compass-rmagick-engine"
  s.summary     = %q{Rmagick sprite engine for compass}
  s.description = %q{Drop in rmagick sprite engine for compass}

  s.rubyforge_project = "compass-rmagick-engine"
  
  s.add_dependency "compass", '~> 0.11.beta.5'
  s.add_dependency "rmagick", '~> 2.13.1'
  

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
