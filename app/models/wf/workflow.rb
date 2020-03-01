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

    scope :valid, -> { where(is_valid: true) }

    after_save do
      do_validate!
    end

    after_touch do
      do_validate!
    end

    # TODO: can from start place to end place
    # todo: remove color hex to const.
    def do_validate!
      msgs = []
      start_place = places.start.first
      end_place   = places.end.first
      msgs << "must have start place" if start_place.blank?
      msgs << "must have only one start place" if places.start.count > 1
      msgs << "must have end place" if end_place.blank?
      msgs << "must have only one end place" if places.end.count > 1
      msgs << "must not have discrete transition" if transitions.any? { |t| !t.arcs.in.exists? }
      if start_place && end_place
        rgl = to_rgl
        places.each do |p|
          msgs << "start place can not reach #{p.name}" unless rgl.path?(start_place.to_gid.to_s, p.to_gid.to_s)
          msgs << "#{p.name} can not reach end_place" unless rgl.path?(p.to_gid.to_s, end_place.to_gid.to_s)
        end

        transitions.each do |t|
          msgs << "start place can not reach #{t.name}" unless rgl.path?(start_place.to_gid.to_s, t.to_gid.to_s)
          msgs << "#{t.name} can not reach end_place" unless rgl.path?(t.to_gid.to_s, end_place.to_gid.to_s)
        end
      end

      if Wf.use_lola
        msgs << "has deadlock" if to_lola.deadlock?
        msgs << "has dead transition" unless to_lola.quasiliveness?
        msgs << "can not reach to the end place" unless to_lola.reachability_of_final_marking?
      end

      if msgs.present?
        update_columns(is_valid: false, error_msg: msgs.join("\n"))
      else
        update_columns(is_valid: true, error_msg: "")
      end
    end

    def to_graph(wf_case = nil, base = nil)
      fontfamily = "system, -apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Noto Color Emoji, Segoe UI Symbol"
      fontfamily_monospace = "SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace"
      graph = base || GraphViz.new(name, type: :digraph, rankdir: "LR", splines: true, ratio: :auto)

      free_token_places = if wf_case
        wf_case.tokens.free.map(&:place_id)
      else
        []
      end
      pg_mapping = {}
      places.order("place_type ASC").each do |p|
        if p.start?
          fillcolor = "#ffe7ba"
          textcolor = "#fa8c16"
          shape     = :doublecircle
        elsif p.end?
          fillcolor = "#dff2ef"
          textcolor = "#29c0b1"
          shape     = :doublecircle
        else
          fillcolor = "#fbdbe1"
          textcolor = "#ff3366"
          shape     = :circle
        end

        token_count = free_token_places.count(p.id)
        if token_count >= 1
          label  = "&bull;"
          xlabel = nil
          fontsize = 25
        else
          label = p.name
          xlabel = nil
        end

        pg = graph.add_nodes(p.graph_id,
                             label: label,
                             xlabel: xlabel,
                             shape: shape,
                             fixedsize: true,
                             style: :filled,
                             fontname: fontfamily,
                             fontcolor: textcolor,
                             fontsize: fontsize,
                             color: fillcolor,
                             fillcolor: fillcolor,
                             href: Wf::Engine.routes.url_helpers.edit_workflow_place_path(self, p))
        pg_mapping[p] = pg
      end

      tg_mapping = {}
      transitions.each do |t|
        peripheries = if t.multiple_instance?
          3
        else
          1
        end
        tg = graph.add_nodes(t.graph_id, label: t.name, shape: :box, style: :filled, fillcolor: "#d6ddfa", color: "#d6ddfa",
                                         fontcolor: "#2c50ed", fontname: fontfamily, peripheries: peripheries,
                                         href: Wf::Engine.routes.url_helpers.edit_workflow_transition_path(self, t))
        tg_mapping[t] = tg
        # NOTICE: if sub_workflow is transition's workflow, then graph will loop infinite, this is valid for workflow definition.
        next unless t.is_sub_workflow? && t.sub_workflow != t.workflow

        sub_graph = graph.add_graph("cluster#{t.sub_workflow_id}", rankdir: "LR", splines: true, ratio: :auto)
        sub_graph[:label] = t.sub_workflow.name
        sub_graph[:style] = :dashed
        sub_graph[:color] = :lightgrey
        # TODO: detect related case for sub workflow.
        t.sub_workflow.to_graph(nil, sub_graph)
        graph.add_edges(tg, t.sub_workflow.places.start.first.graph_id, style: :dashed, dir: :both)
      end

      arcs.order("direction desc").each do |arc|
        label = if arc.guards_count > 0
          arc.guards.map(&:inspect).join(" & ")
        else
          ""
        end
        if arc.in?
          graph.add_edges(
            pg_mapping[arc.place],
            tg_mapping[arc.transition],
            label: label,
            weight: 1,
            labelfloat: false,
            labelfontcolor: :red,
            arrowhead: :vee,
            fontsize: 10,
            color: "#53585c",
            fontcolor: "#53585c",
            fontname: fontfamily_monospace,
            href: Wf::Engine.routes.url_helpers.edit_workflow_arc_path(self, arc)
          )
        else
          graph.add_edges(
            tg_mapping[arc.transition],
            pg_mapping[arc.place],
            label: label,
            weight: 1,
            labelfloat: false,
            labelfontcolor: :red,
            arrowhead: :vee,
            fontsize: 10,
            color: "#53585c",
            fontcolor: "#53585c",
            fontname: fontfamily_monospace,
            href: Wf::Engine.routes.url_helpers.edit_workflow_arc_path(self, arc)
          )
        end
      end
      graph
    end

    def render_graph(wf_case = nil)
      graph = to_graph(wf_case)
      path = Rails.root.join("tmp", "#{id}.svg")
      graph.output(svg: path)
      File.read(path)
    end

    def to_lola
      @lola ||= Wf::Lola.new(self)
    end

    def to_rgl
      graph = RGL::DirectedAdjacencyGraph.new
      places.order("place_type ASC").each do |p|
        graph.add_vertex(p.to_gid.to_s)
      end

      transitions.each do |t|
        graph.add_vertex(t.to_gid.to_s)
      end

      arcs.order("direction desc").each do |arc|
        if arc.in?
          graph.add_edge(arc.place.to_gid.to_s, arc.transition.to_gid.to_s)
        else
          graph.add_edge(arc.transition.to_gid.to_s, arc.place.to_gid.to_s)
        end
      end
      graph
    end
  end
end
