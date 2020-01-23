module Wf::Callbacks
  class Default < ApplicationJob
    queue_as :default
   
    def perform(*guests)
      $stdout.puts(guests.inspect)
    end
  end
end