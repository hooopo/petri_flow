# frozen_string_literal: true

require "wf/engine"

module Wf
  class << self
    attr_accessor :enable_callbacks
    attr_accessor :fire_callbacks
    attr_accessor :assignment_callbacks
    attr_accessor :unassignment_callbacks
    attr_accessor :notification_callbacks
    attr_accessor :time_callbacks
    attr_accessor :deadline_callbacks
    attr_accessor :hold_timeout_callbacks

    attr_accessor :form_class
    attr_accessor :entry_class
    attr_accessor :field_class

    attr_accessor :user_class
    attr_accessor :org_classes

    attr_accessor :finish_conditions

    attr_accessor :use_lola
  end

  self.enable_callbacks          = ["Wf::Callbacks::EnableDefault"]
  self.fire_callbacks            = ["Wf::Callbacks::FireDefault"]
  self.assignment_callbacks      = ["Wf::Callbacks::AssignmentDefault"]
  self.unassignment_callbacks    = ["Wf::Callbacks::UnassignmentDefault"]
  self.notification_callbacks    = ["Wf::Callbacks::NotificationDefault"]
  self.deadline_callbacks        = ["Wf::Callbacks::DeadlineDefault"]
  self.time_callbacks            = ["Wf::Callbacks::TimeDefault"]
  self.hold_timeout_callbacks    = ["Wf::Callbacks::HoldTimeoutDefault"]
  self.form_class                = "::Wf::Form"
  self.entry_class               = "::Wf::Entry"
  self.field_class               = "::Wf::Field"
  self.user_class                = "::Wf::User"
  self.org_classes               = { group: "::Wf::Group" }
  self.finish_conditions         = ["Wf::MultipleInstances::AllFinish"]
  self.use_lola                  = false
end
