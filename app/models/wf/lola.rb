# frozen_string_literal: true

# for each P
# lola --search=cover --encoder=full --formula="AG Pn < oo" a.lola
# lola --formula="EF DEADLOCK" a.lola

# for each T
# lola --formula="AGEF FIREABLE(Tn)" a.lola

# start -> P1, end -> P3
# lola --formula="REACHABLE (P1 = 0 AND P3 = 1)"   a.lola

# PLACE P1,P2,P3;

# MARKING P1;

# TRANSITION T1
# CONSUME P1:1;
# PRODUCE P3:1;

# TRANSITION T2
# CONSUME P3:1;
# PRODUCE P2:1;

module Wf
  class Lola
    attr_reader :workflow
    def initialize(workflow)
      @workflow = workflow
    end

    def to_text
      start_p     = workflow.places.start.first
      end_p       = workflow.places.end.first
      places      = workflow.places
      transitions = workflow.transitions

      places_text  = places.map(&:lola_id).join(",")
      marking_text = start_p.lola_id

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
  end
end
