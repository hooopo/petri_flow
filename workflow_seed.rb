Wf::Workflow.destroy_all
Wf::Case.destroy_all
Wf::Transition.destroy_all
Wf::Place.destroy_all
Wf::Arc.destroy_all
Wf::Form.destroy_all

seq = Wf::Workflow.create(name: 'seq Workflow')
s = seq.places.create!(place_type: :start)
e = seq.places.create!(place_type: :end)
p = seq.places.create!(place_type: :normal)
t1 = seq.transitions.create!(name: 't1')
t2 = seq.transitions.create!(name: 't2')
arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
