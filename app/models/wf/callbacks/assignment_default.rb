# frozen_string_literal: true

module Wf::Callbacks
  class AssignmentDefault < ApplicationJob
    queue_as :default

    def perform(*guests)
      $stdout.puts(guests.inspect)
      [] # return blank default
    end
  end
end
