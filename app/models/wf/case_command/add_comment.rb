# frozen_string_literal: true

module Wf::CaseCommand
  class AddComment
    prepend SimpleCommand
    attr_reader :workitem, :comment, :user
    def initialize(workitem, comment, user)
      @workitem   = workitem
      @comment    = comment
      @user       = user
    end

    def call
      workitem.comments.create!(user: user, body: comment)
    end
  end
end
