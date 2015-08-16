$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_default_association/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_default_association"
  s.version     = HasDefaultAssociation::VERSION
  s.authors     = ["Adam Sanderson"]
  s.email       = ["netghost@gmail.com"]
  s.homepage    = "https://github.com/adamsanderson/has_default_association"
  s.summary     = "Provide default models for ActiveRecord associations"
  # s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
