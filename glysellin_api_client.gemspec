$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "glysellin_api_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "glysellin_api_client"
  s.version     = GlysellinApiClient::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GlysellinApiClient."
  s.description = "TODO: Description of GlysellinApiClient."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.4"
  s.add_dependency "rest-client"
  s.add_dependency "multi_json"
  s.add_dependency "activerecord-tableless", "~> 1.0"

  s.add_development_dependency "sqlite3"
end
