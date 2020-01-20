# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_20_110903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "wf_arcs", force: :cascade do |t|
    t.bigint "workflow_id"
    t.bigint "transition_id"
    t.bigint "place_id"
    t.integer "direction", default: 0, comment: "0-in, 1-out"
    t.integer "arc_type", default: 0, comment: "0-seq,1-explicit_or_split, 2-implicit_or_split, 3-or_join, 4-and_split, 5-and_join"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_cases", force: :cascade do |t|
    t.bigint "workflow_id"
    t.string "targetable_type", comment: "point to target type of Application."
    t.string "targetable_id", comment: "point to target ID of Application."
    t.integer "state", default: 0, comment: "0-created, 1-active, 2-suspended, 3-canceled, 4-finished"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_field_values", force: :cascade do |t|
    t.bigint "workflow_id"
    t.bigint "transitiion_id"
    t.bigint "form_id"
    t.bigint "field_id"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_wf_field_values_on_field_id"
    t.index ["form_id"], name: "index_wf_field_values_on_form_id"
    t.index ["transitiion_id"], name: "index_wf_field_values_on_transitiion_id"
    t.index ["workflow_id"], name: "index_wf_field_values_on_workflow_id"
  end

  create_table "wf_fields", force: :cascade do |t|
    t.string "name"
    t.bigint "form_id"
    t.integer "position", default: 0
    t.integer "field_type", default: 0
    t.string "field_type_name"
    t.string "default_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_wf_fields_on_form_id"
  end

  create_table "wf_forms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_guards", force: :cascade do |t|
    t.bigint "arc_id"
    t.bigint "workflow_id"
    t.string "fieldable_type"
    t.string "fieldable_id"
    t.string "op"
    t.string "value"
    t.string "exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["arc_id"], name: "index_wf_guards_on_arc_id"
    t.index ["workflow_id"], name: "index_wf_guards_on_workflow_id"
  end

  create_table "wf_places", force: :cascade do |t|
    t.bigint "workflow_id"
    t.string "name"
    t.text "description"
    t.integer "sort_order", default: 0
    t.integer "place_type", default: 0, comment: "类型：0-normal，1-start，2-end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_tokens", force: :cascade do |t|
    t.bigint "workflow_id"
    t.bigint "case_id"
    t.string "targetable_type"
    t.string "targetable_id"
    t.bigint "place_id"
    t.integer "state", default: 0, comment: "0-free, 1-locked, 2-canceled, 3-consumed"
    t.bigint "workitem_id"
    t.bigint "locked_workitem_id"
    t.datetime "produced_at", default: -> { "timezone('utc'::text, now())" }
    t.datetime "locked_at"
    t.datetime "canceled_at"
    t.datetime "consumed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_transition_assignments", force: :cascade do |t|
    t.bigint "workflow_id"
    t.bigint "transition_id"
    t.string "assignable_type", comment: "Assign Type from Application: Group or Role or User etc."
    t.string "assignable_id", comment: "Assign ID from Application: group_id or role_id or user_id etc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_transitions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "workflow_id"
    t.integer "sort_order", default: 0
    t.integer "trigger_limit", comment: "use with timed trigger, after x minitues, trigger exec"
    t.integer "trigger_type", default: 0, comment: "0-user,1-automatic, 2-message,3-time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "form_id"
  end

  create_table "wf_workflows", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_valid", default: false
    t.boolean "is_draft", default: true
    t.bigint "creator_id"
    t.text "error_msg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_workitems", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "workflow_id"
    t.bigint "transition_id"
    t.string "targetable_type", comment: "point to type of Application target: Task or Issue or PullRequest or Project etc."
    t.string "targetable_id", comment: "point to id of Application target: task_id or issue_id or pull_request_id or project_id etc."
    t.integer "state", default: 0, comment: "0-enabled, 1-started, 2-canceled, 3-finished,4-overridden"
    t.datetime "enabled_at", default: -> { "timezone('utc'::text, now())" }
    t.datetime "started_at"
    t.datetime "canceled_at"
    t.datetime "finished_at"
    t.datetime "overridden_at"
    t.datetime "deadline", comment: "set when transition_trigger=TIME"
    t.string "user_type", comment: "point to type of Application user: User or Member or Account etc."
    t.string "user_id", comment: "point to type fo Application user id: user_id or member_id or account_id etc."
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
