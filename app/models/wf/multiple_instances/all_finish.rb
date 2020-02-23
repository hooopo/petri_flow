# frozen_string_literal: true

module Wf
  module MultipleInstances
    class AllFinish
      def perform(_workitem)
        false
      end
    end
  end
end
