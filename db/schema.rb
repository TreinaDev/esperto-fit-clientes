git# This file is auto-generated from the current state of the database. Instead
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

ActiveRecord::Schema.define(version: 2020_10_10_233955) do

  create_table "appointments", force: :cascade do |t|
    t.time "appointment_time"
    t.date "appointment_date"
    t.integer "personal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "price_per_hour"
    t.integer "status", default: 0
    t.index ["personal_id"], name: "index_appointments_on_personal_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_clients_on_cpf", unique: true
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "enrolls", force: :cascade do |t|
    t.integer "subsidiary_id"
    t.integer "plan_id"
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "payment_option_id", null: false
    t.index ["client_id"], name: "index_enrolls_on_client_id"
    t.index ["payment_option_id"], name: "index_enrolls_on_payment_option_id"
  end

  create_table "order_appointments", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "appointment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appointment_id"], name: "index_order_appointments_on_appointment_id"
    t.index ["client_id"], name: "index_order_appointments_on_client_id"
  end

  create_table "payment_options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_payment_options_on_name", unique: true
  end

  create_table "personals", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.string "cref"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_personals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_personals_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "enroll_id", null: false
    t.index ["enroll_id"], name: "index_profiles_on_enroll_id"
  end

  add_foreign_key "appointments", "personals"
  add_foreign_key "enrolls", "clients"
  add_foreign_key "enrolls", "payment_options"
  add_foreign_key "order_appointments", "appointments"
  add_foreign_key "order_appointments", "clients"
  add_foreign_key "profiles", "enrolls"
end
