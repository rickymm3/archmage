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

ActiveRecord::Schema.define(version: 20140925212517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armies", force: true do |t|
    t.string   "name"
    t.integer  "barracks_lvl"
    t.boolean  "is_summon",    default: false
    t.string   "description"
    t.integer  "gold_upkeep"
    t.integer  "mana_upkeep"
    t.integer  "lvl"
    t.integer  "str"
    t.integer  "spd"
    t.integer  "int"
    t.integer  "population"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buff_effects", force: true do |t|
    t.integer  "value"
    t.boolean  "is_percent",    default: false
    t.string   "stat_effected"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "spell_buffs", force: true do |t|
    t.integer  "spell_id"
    t.integer  "buff_effect_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spells", force: true do |t|
    t.string   "name"
    t.integer  "element_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "target"
    t.integer  "mana_cost"
    t.integer  "mana_upkeep"
  end

  create_table "structures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "mana_cost"
    t.integer  "gold_cost"
    t.decimal  "mana_multiple", precision: 3, scale: 2
    t.decimal  "gold_multiple", precision: 3, scale: 2
  end

  create_table "user_armies", force: true do |t|
    t.integer  "army_id"
    t.integer  "user_id"
    t.integer  "number_owned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "num1"
    t.integer  "num2"
    t.integer  "num3"
    t.integer  "num4"
    t.integer  "num5"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed",          default: false
    t.string   "str1"
    t.string   "str2"
    t.string   "str3"
    t.datetime "date1"
    t.datetime "date2"
    t.datetime "date3"
    t.integer  "notification_id"
  end

  create_table "user_spells", force: true do |t|
    t.integer  "spell_id"
    t.integer  "user_id"
    t.datetime "began"
    t.datetime "ends"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_structures", force: true do |t|
    t.integer  "user_id"
    t.integer  "structure_id"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "user_id"
    t.string   "message"
    t.integer  "gold"
    t.integer  "mana"
    t.datetime "last_collect_gold_at"
    t.datetime "last_collect_mana_at"
    t.integer  "orb_count"
    t.datetime "orb_updated_at"
    t.integer  "land"
    t.datetime "explore_start"
    t.datetime "explore_end"
    t.boolean  "is_exploring"
    t.integer  "uncollected_gold"
    t.integer  "uncollected_mana"
    t.integer  "favor"
    t.datetime "last_update_at",         default: '2014-09-22 14:19:11'
    t.integer  "element_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
