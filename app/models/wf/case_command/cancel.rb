module Wf::CaseCommand
  class Cancel
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      raise("Only active or suspended cases can be canceled") unless (wf_case.suspended? or wf_case.active?)
      wf_case.canceled!
    end
  end
end