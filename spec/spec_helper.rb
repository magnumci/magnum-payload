require 'simplecov'
SimpleCov.start do
  add_filter "/.bundle/"
  add_group "Magnum::Payload", "lib/magnum/payload"
end

require "magnum/payload"

def fixture_path(filename=nil)
  path = File.expand_path("../fixtures", __FILE__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end