# frozen_string_literal: true

module Wf
  class Engine < ::Rails::Engine
    isolate_namespace Wf
    config.autoload_paths += %W(
      #{config.root}/app/models/wf/concerns
    )
  end
end
