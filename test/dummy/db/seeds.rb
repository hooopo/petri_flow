# frozen_string_literal: true

Wf::Workflow.destroy_all
Wf::Case.destroy_all
Wf::Transition.destroy_all
Wf::Place.destroy_all
Wf::Arc.destroy_all
Wf::Form.destroy_all

form = Wf.form_class.constantize.create(name: "From One")
name_field = form.fields.create!(name: :name, field_type: :string)
age_field = form.fields.create!(name: :age, field_type: :integer)

form2 = Wf.form_class.constantize.create(name: "From Two")
score_field = form2.fields.create!(name: :score, field_type: :integer)

proc do
  seq = Wf::Workflow.create(name: "Seq Workflow")
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
  seq = Wf::Workflow.create(name: "Workflow with automatic transition")
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
  seq = Wf::Workflow.create(name: "Workflow with timed transition")
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
  seq = Wf::Workflow.create(name: "Workflow with timed split")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1")
  t2 = seq.transitions.create!(name: "t2")
  t3 = seq.transitions.create!(name: "t3", trigger_type: :time, trigger_limit: 1)

  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :in, transition: t3, place: s)
  arc3 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc4 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc5 = seq.arcs.create!(direction: :out, transition: t2, place: e)
  arc6 = seq.arcs.create!(direction: :out, transition: t3, place: e)
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

proc do
  seq = Wf::Workflow.create(name: "Workflow with parallel routing")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p1 = seq.places.create!(place_type: :normal, name: "p1")
  p2 = seq.places.create!(place_type: :normal, name: "p2")
  p3 = seq.places.create!(place_type: :normal, name: "p3")
  p4 = seq.places.create!(place_type: :normal, name: "p4")
  t1 = seq.transitions.create!(name: "t1", form: form)
  t2 = seq.transitions.create!(name: "t2")
  t3 = seq.transitions.create!(name: "t3")
  t4 = seq.transitions.create!(name: "t4")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p1)
  arc3 = seq.arcs.create!(direction: :out, transition: t1, place: p2)
  arc4 = seq.arcs.create!(direction: :in, transition: t2, place: p1)
  arc5 = seq.arcs.create!(direction: :in, transition: t3, place: p2)
  arc6 = seq.arcs.create!(direction: :out, transition: t2, place: p3)
  arc7 = seq.arcs.create!(direction: :out, transition: t3, place: p4)
  arc8 = seq.arcs.create!(direction: :in, transition: t4, place: p3)
  arc9 = seq.arcs.create!(direction: :in, transition: t4, place: p4)
  arc10 = seq.arcs.create!(direction: :out, transition: t4, place: e)
end.call

proc do
  seq = Wf::Workflow.create(name: "Workflow with iterative routing")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1", form: form)
  t2 = seq.transitions.create!(name: "t2")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
  arc5 = seq.arcs.create!(direction: :out, transition: t1, place: s)
  arc5.guards.create!(fieldable: age_field, op: ">".to_sym, value: 18)
end.call

proc do
  seq = Wf::Workflow.create(name: "Workflow with expression guard")
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
  exp = <<~JS
    let age_great_than_18 = function(){
      if (workitem.form.age > 18) {
        return "Yes"
      } else {
        return "No"
      }
    };
    age_great_than_18();
  JS
  arc3.guards.create!(exp: exp, op: "=".to_sym, value: "Yes")
end.call

proc do
  sub_workflow = Wf::Workflow.where(name: "Seq Workflow").first
  seq = Wf::Workflow.create(name: "Workflow with sub workflow")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1", sub_workflow: sub_workflow, trigger_type: :message)
  t2 = seq.transitions.create!(name: "t2")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
end.call

proc do
  seq = Wf::Workflow.create(name: "Workflow with multiple instances")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1", trigger_type: :user, multiple_instance: true, form: form2)
  t2 = seq.transitions.create!(name: "t2")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
  Wf::User.all.sample(3).each do |user|
    t1.transition_static_assignments.create!(party: user.party)
  end
end.call

proc do
  seq = Wf::Workflow.create(name: "Workflow with AssigmentCallback")
  s = seq.places.create!(place_type: :start, name: "start")
  e = seq.places.create!(place_type: :end, name: "end")
  p = seq.places.create!(place_type: :normal, name: "p")
  t1 = seq.transitions.create!(name: "t1", assignment_callback: "MyAssignmentCallback")
  t2 = seq.transitions.create!(name: "t2")
  arc1 = seq.arcs.create!(direction: :in, transition: t1, place: s)
  arc2 = seq.arcs.create!(direction: :out, transition: t1, place: p)
  arc3 = seq.arcs.create!(direction: :in, transition: t2, place: p)
  arc4 = seq.arcs.create!(direction: :out, transition: t2, place: e)
end.call
