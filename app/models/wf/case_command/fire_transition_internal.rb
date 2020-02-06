# frozen_string_literal: true

module Wf::CaseCommand
  class FireTransitionInternal
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      if workitem.enabled?
        locked_item = nil
      elsif workitem.started?
        locked_item = workitem
      else
        raise("can not fire the transition if it is not in state enabled or started.")
      end
      Wf::ApplicationRecord.transaction do
        workitem.update!(finished_at: Time.zone.now, state: :finished)
        # TODO: only in?
        workitem.transition.arcs.each do |arc|
          ConsumeToken.call(workitem.case, arc.place, locked_item)
        end
        # last arc without guard -> pass
        has_passed = false
        workitem.transition.arcs.out.order("guards_count DESC").each do |arc|
          if workitem.transition.explicit_or_split?
            if workitem.pass_guard?(arc, has_passed)
              has_passed = true
              AddToken.call(workitem.case, arc.place)
            end
          else
            AddToken.call(workitem.case, arc.place)
          end
        end
        workitem.transition.fire_callback.constantize.new(workitem.id).perform_now
      end
    end
  end
end
