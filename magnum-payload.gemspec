require File.expand_path("../lib/magnum/payload/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "magnum-payload"
  spec.version     = Magnum::Payload::VERSION
  spec.summary     = "Code payload parser"
  spec.description = "Parse code pushes from multiple code hosting platforms"
  spec.homepage    = "https://github.com/magnumci/magnum-payload"
  spec.authors     = ["Dan Sosedoff"]
  spec.email       = ["dan.sosedoff@gmail.com"]
  spec.license     = "MIT"
  
  spec.add_development_dependency "rake",      "~> 10"
  spec.add_development_dependency "rspec",     "~> 2.13"
  spec.add_development_dependency "simplecov", "~> 0.8"

  spec.add_runtime_dependency "json", ">= 1.8"
  spec.add_runtime_dependency "hashr", ">= 0"
  
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end