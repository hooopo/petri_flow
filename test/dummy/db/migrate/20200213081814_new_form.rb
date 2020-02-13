# frozen_string_literal: true

class NewForm < ActiveRecord::Migration[6.0]
  def change
    create_table "field_values", force: :cascade do |t|
      t.bigint "entry_id"
      t.bigint "form_id"
      t.bigint "field_id"
      t.text "value"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
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

    create_table :entries do |t|
      t.string :user_id, index: true
      t.bigint :workitem_id, index: true
      t.json "payload"
      t.timestamps
    end
    add_index :entries, %i[workitem_id user_id], unique: true
  end
end
