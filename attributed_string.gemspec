$:.push File.expand_path("../lib", __FILE__)

require "attributed_string/version"

Gem::Specification.new do |s|
  s.name        = "attributed_string"
  s.version     = AttributedString::VERSION
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@newspaperclub.com"]
  s.homepage    = "http://www.newspaperclub.com"
  s.summary     = ""

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "rspec", "~> 3.0"
end
