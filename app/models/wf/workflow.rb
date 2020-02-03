# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_workflows
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  is_valid    :boolean          default("false")
#  creator_id  :string
#  error_msg   :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class Workflow < ApplicationRecord
    has_many :places, dependent: :destroy
    has_many :transitions, dependent: :destroy
    has_many :arcs, dependent: :destroy
    has_many :transition_static_assignments
    has_many :cases
    has_many :workitems
    has_many :tokens

    validates :name, presence: true

    # TODO: move to config
    def self.enable_callbacks
      [Wf::Callbacks::EnableDefault]
    end

    def self.fire_callbacks
      [Wf::Callbacks::FireDefault]
    end

    def self.assignment_callbacks
      [Wf::Callbacks::AssignmentDefault]
    end

    def self.unassignment_callbacks
      [Wf::Callbacks::UnassignmentDefault]
    end

    def self.notification_callbacks
      [Wf::Callbacks::NotificationDefault]
    end

    def self.deadline_callbacks
      [Wf::Callbacks::DeadlineDefault]
    end

    def self.time_callbacks
      [Wf::Callbacks::TimeDefault]
    end

    def self.hold_timeout_callbacks
      [Wf::Callbacks::HoldTimeoutDefault]
    end

    def self.user_class
      ::Wf::User
    end

    def self.org_class
      [::Wf::Group]
    end

    after_save do
      do_validate!
    end

    after_touch do
      do_validate!
    end

    # TODO: can from start place to end place
    def do_validate!
      msgs = []
      msgs << "must have start place" if places.start.blank?
      msgs << "must have only one start place" if places.start.count > 1
      msgs << "must have end place" if places.end.blank?
      msgs << "must have only one end place" if places.end.count > 1
      if msgs.present?
        update_columns(is_valid: false, error_msg: msgs.join("\n"))
      else
        update_columns(is_valid: true, error_msg: "")
      end
    end

    def to_graph
      graph = GraphViz.new(name, type: :digraph)
      tg_mapping = {}
      transitions.each do |t|
        tg = graph.add_nodes(t.name, label: t.name, shape: :box, href: Wf::Engine.routes.url_helpers.edit_workflow_transition_path(self, t))
        tg_mapping[t] = tg
      end

      pg_mapping = {}
      places.order("place_type ASC").each do |p|
        pg = graph.add_nodes(p.name, label: p.name, shape: :circle, fixedsize: true, href: Wf::Engine.routes.url_helpers.edit_workflow_place_path(self, p))
        pg_mapping[p] = pg
      end

      arcs.each do |arc|
        if arc.in?
          graph.add_edges(pg_mapping[arc.place], tg_mapping[arc.transition], href: Wf::Engine.routes.url_helpers.edit_workflow_arc_path(self, arc))
        else
          graph.add_edges(tg_mapping[arc.transition], pg_mapping[arc.place], href: Wf::Engine.routes.url_helpers.edit_workflow_arc_path(self, arc))
        end
      end
      graph
    end

    def render_graph
      graph = to_graph
      path = Rails.root.join("tmp", "#{id}.svg")
      graph.output(svg: path)
      File.read(path)
    end
  end
end
