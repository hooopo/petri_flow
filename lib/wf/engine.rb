# frozen_string_literal: true

module Wf
  class Engine < ::Rails::Engine
    isolate_namespace Wf
    config.autoload_paths += %W[
      #{config.root}/app/models/wf/concerns
    ]
  end
end

require "bootstrap"
require "bootstrap4-kaminari-views"
require "jquery-rails"
require "kaminari"
require "simple_command"
require "loaf"
require "graphviz"
