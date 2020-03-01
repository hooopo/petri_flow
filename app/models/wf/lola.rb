# frozen_string_literal: true

## generate lola format file.

# PLACE P1,P2,P3;

# MARKING P1;

# TRANSITION T1
# CONSUME P1:1;
# PRODUCE P3:1;

# TRANSITION T2
# CONSUME P3:1;
# PRODUCE P2:1;

## checking

# reachability of final marking
# lola /Users/hooopo/w/wf/test/dummy/tmp/1-1582990693.lola --formula="AGEF(P1 = 0 AND P3 = 0 AND P2 = 1)" --json=/Users/hooopo/w/wf/test/dummy/tmp/1-reachability_of_final_marking.json

# quasiliveness
# lola /Users/hooopo/w/wf/test/dummy/tmp/1-1582990693.lola --formula="AG NOT FIREABLE (T1)" --json=/Users/hooopo/w/wf/test/dummy/tmp/1-dead_transition_1.json
# lola /Users/hooopo/w/wf/test/dummy/tmp/1-1582990693.lola --formula="AG NOT FIREABLE (T2)" --json=/Users/hooopo/w/wf/test/dummy/tmp/1-dead_transition_2.json
# deadlock
# lola /Users/hooopo/w/wf/test/dummy/tmp/1-1582990693.lola --formula="EF (DEADLOCK AND (P2 = 0))" --json=/Users/hooopo/w/wf/test/dummy/tmp/1-deadlock.json

module Wf
  class Lola
    attr_reader :end_p, :start_p, :workflow
    def initialize(workflow)
      @workflow = workflow
      @start_p  = workflow.places.start.first
      @end_p    = workflow.places.end.first
      generate_lola_file!
    end

    def to_text
      places      = workflow.places
      transitions = workflow.transitions

      places_text  = places.map(&:lola_id).join(",")
      marking_text = start_p.lola_id
      # TODO: with guard
      transitions_text = transitions.map do |t|
        consume = t.arcs.in.map { |arc| "#{arc.place.lola_id}:1" }.join(",")
        produce = t.arcs.out.map { |arc| "#{arc.place.lola_id}:1" }.join(",")
        [
          "TRANSITION #{t.lola_id}",
          "CONSUME #{consume};",
          "PRODUCE #{produce};"
        ].join("\n")
      end.join("\n\n")

      <<~LOLA
        PLACE #{places_text};

        MARKING #{marking_text};

        #{transitions_text}
      LOLA
    end

    def json_path(bucket)
      Rails.root.join("tmp", "#{workflow.id}-#{bucket}.json")
    end

    def lola_path
      Rails.root.join("tmp", "#{workflow.id}-#{workflow.updated_at.to_i}.lola")
    end

    def generate_lola_file!
      File.open(lola_path, "w") { |f| f.write(Wf::Lola.new(workflow).to_text) } unless File.exist?(lola_path)
    end

    def soundness?
      reachability_of_final_marking? && quasiliveness? && !deadlock?
    end

    def deadlock?
      formula = "EF (DEADLOCK AND (#{end_p.lola_id} = 0))"
      result = run_cmd(formula, "deadlock")
      result.dig("analysis", "result")
    end

    # reachability of final marking
    def reachability_of_final_marking?
      formula = workflow.places.reject { |p| p == end_p }.map { |p| "#{p.lola_id} = 0" }.join(" AND ")
      formula += " AND #{end_p.lola_id} = 1"
      formula = "AGEF(#{formula})"
      result = run_cmd(formula, "reachability_of_final_marking")
      result.dig("analysis", "result")
    end

    def quasiliveness?
      workflow.transitions.all? { |t| !dead_transition?(t) }
    end

    private

      def dead_transition?(transition)
        formula = "AG NOT FIREABLE (#{transition.lola_id})"
        result = run_cmd(formula, "dead_transition_#{transition.id}")
        result.dig("analysis", "result")
      end

      def run_cmd(formula, bucket)
        cmd = %(lola #{lola_path} --markinglimit=1000 --formula="#{formula}" --json=#{json_path(bucket)})
        $stdout.puts cmd
        system(cmd)
        JSON.parse(File.read(json_path(bucket)))
      end
  end
end
