require File.expand_path('../lib/magnum/payload/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "magnum-payload"
  s.version     = Magnum::Payload::VERSION
  s.summary     = "Magnum Payload"
  s.description = "Magnum Payload"
  s.homepage    = "http://meth.not.even.once"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]
  
  s.add_development_dependency 'rake',      '~> 10'
  s.add_development_dependency 'rspec',     '~> 2.13'
  s.add_development_dependency 'simplecov', '~> 0.7'

  s.add_runtime_dependency 'multi_json', '~> 1.7'
  s.add_runtime_dependency 'hashr', '>= 0'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
end