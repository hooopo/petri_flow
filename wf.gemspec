# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "wf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "wf"
  spec.version     = Wf::VERSION
  spec.authors     = ["Hooopo Wang"]
  spec.email       = ["hoooopo@gmail.com"]
  spec.homepage    = "https://github.com/hooopo/wf"
  spec.summary     = "Summary of Wf."
  spec.description = "Description of Wf."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"

  spec.add_development_dependency "pg"
end
