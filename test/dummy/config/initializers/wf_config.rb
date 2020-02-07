# frozen_string_literal: true

# TODO: use setter
Wf::Workflow.class_eval do
  def self.user_class
    ::Wf::User
  end

  def self.org_classes
    { group: ::Wf::Group }
  end
end
