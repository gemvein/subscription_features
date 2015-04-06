# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150406172005) do

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "setting_type"
    t.text   "description"
  end

  add_index "features", ["name"], name: "index_features_on_name", unique: true

  create_table "features_plans", force: :cascade do |t|
    t.integer "feature_id"
    t.integer "plan_id"
    t.integer "setting"
  end

  add_index "features_plans", ["feature_id"], name: "index_features_plans_on_feature_id"
  add_index "features_plans", ["plan_id"], name: "index_features_plans_on_plan_id"

  create_table "plans", force: :cascade do |t|
    t.decimal  "charge"
    t.string   "period"
    t.integer  "cycles"
    t.string   "name"
    t.text     "description"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["name"], name: "index_plans_on_name", unique: true

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id"
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.datetime "charged_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["subscriber_type", "subscriber_id"], name: "index_subscriptions_on_subscriber_type_and_subscriber_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end