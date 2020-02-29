# frozen_string_literal: true

class MyAssignmentCallback
  def perform(_workitem_id)
    Wf::Party.all.sample(2)
  end
end

Wf.assignment_callbacks = ["Wf::Callbacks::AssignmentDefault", "MyAssignmentCallback"]
