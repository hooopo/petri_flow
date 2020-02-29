# frozen_string_literal: true

module Wf::Callbacks
  class AssignmentDefault < ApplicationJob
    queue_as :default

    def perform(workitem_id)
      # return Party array.
      []
    end
  end
end
