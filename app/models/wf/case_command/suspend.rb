module Wf::CaseCommand
  class Suspend
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      raise("Only active or suspended cases can be canceled") unless wf_case.active?
      wf_case.suspended!
    end
  end
end