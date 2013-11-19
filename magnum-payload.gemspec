require File.expand_path('../lib/magnum/payload/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "magnum-payload"
  s.version     = Magnum::Payload::VERSION
  s.summary     = "Code payload parser"
  s.description = "Allows to parse code payloads from Github, Bitbucket and many more"
  s.homepage    = "https://github.com/magnumci/magnum-payload"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]
  s.license     = 'MIT'
  
  s.add_development_dependency 'rake',      '~> 10'
  s.add_development_dependency 'rspec',     '~> 2.13'
  s.add_development_dependency 'simplecov', '~> 0.8'

  s.add_runtime_dependency 'json', '>= 1.8'
  s.add_runtime_dependency 'hashr', '>= 0'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
end