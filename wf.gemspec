# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "wf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "petri_flow"
  spec.version     = Wf::VERSION
  spec.authors     = ["Hooopo Wang"]
  spec.email       = ["hoooopo@gmail.com"]
  spec.homepage    = "https://github.com/hooopo/petri_flow"
  spec.summary     = "Petri Net Workflow Engine for Ruby."
  spec.description = "Petri Net Workflow Engine for Ruby."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "bootstrap", "~> 4.4.1"
  spec.add_dependency "bootstrap4-kaminari-views"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "kaminari"
  spec.add_dependency "loaf"
  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"
  spec.add_dependency "rgl"
  spec.add_dependency "ruby-graphviz"
  spec.add_dependency "simple_command"
end
