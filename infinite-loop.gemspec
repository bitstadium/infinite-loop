# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "infinite"

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas Dohmke"]
  gem.email         = ["thomas@dohmke.de"]
  gem.description   = "A command-line interface for HockeyApp"
  gem.summary       = "Infinite Loop"
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "infinite-loop"
  gem.require_paths = ["lib"]
  gem.version       = Infinite::VERSION

  gem.add_dependency "cupertino"
  gem.add_dependency "rest-client"
  gem.add_dependency "json"
end
