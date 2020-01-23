# frozen_string_literal: true

module Wf::CaseCommand
  class Resume
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      raise("Only suspended or canceled cases can be resumed") unless wf_case.suspended? || wf_case.canceled?

      wf_case.active!
    end
  end
end
