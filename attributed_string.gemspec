$:.push File.expand_path("../lib", __FILE__)

require "attributed_string/version"

Gem::Specification.new do |s|
  s.name        = "attributed_string"
  s.version     = AttributedString::VERSION
  s.licenses    = ['MIT']
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@newspaperclub.com"]
  s.homepage    = "https://github.com/newspaperclub/attributed_string"
  s.summary     = "A String class, but with attributes marking data at specific ranges."

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "rspec", "~> 3.0"
end
