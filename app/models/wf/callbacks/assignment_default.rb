# frozen_string_literal: true

module Wf::Callbacks
  class AssignmentDefault < ApplicationJob
    queue_as :default

    def perform(_workitem_id)
      # return Party array.
      []
    end
  end
end
