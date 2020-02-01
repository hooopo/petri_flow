# frozen_string_literal: true

Wf::Workflow.destroy_all
Wf::Case.destroy_all
Wf::Transition.destroy_all
Wf::Place.destroy_all
Wf::Arc.destroy_all
Wf::Form.destroy_all

form = Wf::Form.create(name: "From One")
name_field = form.fields.create!(name: :name, field_type: :string)
age_field = form.fields.create!(name: :age, field_type: :integer)

proc do
  seq = Wf::Workflow.create(name: "seq Workflow")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1")
  t2 = seq.transitions.create!(name: "t2")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
end.call

proc do
  seq = Wf::Workflow.create(name: "seq with auto Workflow")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1")
  t2 = seq.transitions.create!(name: "t2", trigger_type: :automatic)
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
end.call

proc do
  seq = Wf::Workflow.create(name: "seq with time Workflow")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1")
  t2 = seq.transitions.create!(name: "t2", trigger_type: :time, trigger_limit: 1)
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
end.call

proc do
  seq = Wf::Workflow.create(name: "Workflow with guard")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p1 = seq.places.create!(place_type: :normal, name: "p1")
  p2 = seq.places.create!(place_type: :normal, name: "p2")
  t1 = seq.transitions.create!(name: "t1", form: form)
  t2 = seq.transitions.create!(name: "t2")
  t3 = seq.transitions.create!(name: "t3")
  arc2 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc3 = seq.arcs.create!(direction: :out, transition: t1, place: p1)
  arc3 = seq.arcs.create!(direction: :out, transition: t1, place: p2)
  arc4 = seq.arcs.create!(direction: :in, transition: t2, place: p1)
  arc5 = seq.arcs.create!(direction: :in, transition: t3, place: p2)
  arc6 = seq.arcs.create!(direction: :out, transition: t2, place: e)
  arc7 = seq.arcs.create!(direction: :out, transition: t3, place: e)
  arc3.guards.create!(fieldable: age_field, op: ">".to_sym, value: 18)
end.call
