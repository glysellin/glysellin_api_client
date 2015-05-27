$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "glysellin/api_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "glysellin_api_client"
  s.version     = Glysellin::ApiClient::VERSION
  s.authors     = ["Valentin Ballestrino", "Yassine Zenati"]
  s.email       = ["contact@glyph.fr"]
  s.homepage    = "http://www.glyph.fr"
  s.summary     = "Client API library for Glysellin e-commerce engine"
  s.description = "Client API library for Glysellin e-commerce engine"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "rest-client"
  s.add_dependency "multi_json"
  s.add_dependency "request_store"

  s.add_development_dependency "sqlite3"
end
