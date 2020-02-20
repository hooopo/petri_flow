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

ActiveRecord::Schema.define(version: 2020_02_20_070839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string "user_id"
    t.bigint "workitem_id"
    t.json "payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "form_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
    t.index ["workitem_id", "user_id"], name: "index_entries_on_workitem_id_and_user_id", unique: true
    t.index ["workitem_id"], name: "index_entries_on_workitem_id"
  end

  create_table "field_values", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "field_id"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "entry_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.bigint "form_id"
    t.integer "position", default: 0
    t.integer "field_type", default: 0
    t.string "field_type_name"
    t.string "default_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_fields_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_arcs", force: :cascade do |t|
    t.bigint "workflow_id"
    t.bigint "transition_id"
    t.bigint "place_id"
    t.integer "direction", default: 0, comment: "0-in, 1-out"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "guards_count", default: 0
  end

  create_table "wf_case_assignments", comment: "Manual per-case assignments of transition to parties", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "transition_id"
    t.bigint "party_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id", "transition_id", "party_id"], name: "wf_ctp_u", unique: true
  end

  create_table "wf_cases", force: :cascade do |t|
    t.bigint "workflow_id"
    t.string "targetable_type", comment: "point to target type of Application."
    t.string "targetable_id", comment: "point to target ID of Application."
    t.integer "state", default: 0, comment: "0-created, 1-active, 2-suspended, 3-canceled, 4-finished"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_comments", force: :cascade do |t|
    t.bigint "workitem_id"
    t.string "user_id"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wf_comments_on_user_id"
    t.index ["workitem_id"], name: "index_wf_comments_on_workitem_id"
  end

  create_table "wf_demo_targets", comment: "For demo, useless.", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_entries", comment: "user input data for workitem with form.", force: :cascade do |t|
    t.string "user_id"
    t.bigint "workitem_id"
    t.json "payload", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "form_id"
    t.index ["user_id"], name: "index_wf_entries_on_user_id"
    t.index ["workitem_id", "user_id"], name: "index_wf_entries_on_workitem_id_and_user_id", unique: true
    t.index ["workitem_id"], name: "index_wf_entries_on_workitem_id"
  end

  create_table "wf_field_values", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "field_id"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "entry_id"
    t.index ["field_id"], name: "index_wf_field_values_on_field_id"
    t.index ["form_id"], name: "index_wf_field_values_on_form_id"
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

  create_table "wf_groups", comment: "For demo", force: :cascade do |t|
    t.string "name"
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

  create_table "wf_parties", comment: "for groups or roles or users or positions etc.", force: :cascade do |t|
    t.string "partable_type"
    t.string "partable_id"
    t.string "party_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partable_type", "partable_id"], name: "index_wf_parties_on_partable_type_and_partable_id", unique: true
  end

  create_table "wf_places", force: :cascade do |t|
    t.bigint "workflow_id"
    t.string "name"
    t.text "description"
    t.integer "sort_order", default: 0
    t.integer "place_type", default: 0, comment: "类型：0-start，1-normal，2-end"
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
    t.bigint "locked_workitem_id"
    t.datetime "produced_at", default: -> { "timezone('utc'::text, now())" }
    t.datetime "locked_at"
    t.datetime "canceled_at"
    t.datetime "consumed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_transition_static_assignments", comment: "pre assignment for transition", force: :cascade do |t|
    t.bigint "party_id"
    t.bigint "transition_id"
    t.bigint "workflow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["transition_id", "party_id"], name: "wf_tp_u", unique: true
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
    t.string "enable_callback", default: "Wf::Callbacks::EnableDefault"
    t.string "fire_callback", default: "Wf::Callbacks::FireDefault"
    t.string "notification_callback", default: "Wf::Callbacks::NotificationDefault"
    t.string "time_callback", default: "Wf::Callbacks::TimeDefault"
    t.string "deadline_callback", default: "Wf::Callbacks::DeadlineDefault"
    t.string "hold_timeout_callback", default: "Wf::Callbacks::HoldTimeoutDefault"
    t.string "assignment_callback", default: "Wf::Callbacks::AssignmentDefault"
    t.string "unassignment_callback", default: "Wf::Callbacks::UnassignmentDefault"
    t.string "form_type", default: "Wf::Form"
    t.index ["form_type", "form_id"], name: "index_wf_transitions_on_form_type_and_form_id"
  end

  create_table "wf_users", comment: "For demo", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id"
  end

  create_table "wf_workflows", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_valid", default: false
    t.string "creator_id"
    t.text "error_msg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wf_workitem_assignments", force: :cascade do |t|
    t.bigint "party_id"
    t.bigint "workitem_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workitem_id", "party_id"], name: "wf_wp_u", unique: true
  end

  create_table "wf_workitems", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "workflow_id"
    t.bigint "transition_id"
    t.integer "state", default: 0, comment: "0-enabled, 1-started, 2-canceled, 3-finished,4-overridden"
    t.datetime "enabled_at", default: -> { "timezone('utc'::text, now())" }
    t.datetime "started_at"
    t.datetime "canceled_at"
    t.datetime "finished_at"
    t.datetime "overridden_at"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "trigger_time", comment: "set when transition_trigger=TIME & trigger_limit present"
    t.string "holding_user_id", comment: "id of App user"
    t.index ["state", "trigger_time"], name: "index_wf_workitems_on_state_and_trigger_time"
  end

end
