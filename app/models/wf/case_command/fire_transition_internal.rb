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

      workitem.update!(finished_at: Time.now, state: :finished)
      # TODO only in?
      workitem.transition.arcs.each do |arc|
        ConsumeToken.call(workitem.case, arc.place, locked_item)
      end
      workitem.transition.arcs.out.each do |arc|
        AddToken.call(workitem.case, arc.place) unless workitem.pass_guard?(arc)
      end
    end
  end
end