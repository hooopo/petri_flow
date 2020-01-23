module Wf::CaseCommand
  class SweepAutomaticTransitions
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      EnableTransitions.call(wf_case)
      
    end
  end
end