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

ActiveRecord::Schema.define(version: 20190119232850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.string   "campaign_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coc_campaigns", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer  "owner_id"
  end

  create_table "coc_characteristic_sets", force: :cascade do |t|
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "constitution"
    t.integer  "appearance"
    t.integer  "power"
    t.integer  "size"
    t.integer  "education"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coc_characters", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "occupation"
    t.string   "degrees"
    t.string   "birthplace"
    t.string   "gender"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "weapon_ids"
    t.string   "residence"
    t.string   "personal_description"
    t.text     "family_and_friends"
    t.string   "episodes_of_insanity"
    t.string   "wounds_and_injuries"
    t.string   "marks_and_scars"
    t.text     "history"
    t.string   "income"
    t.string   "cash"
    t.string   "savings"
    t.string   "property"
    t.string   "real_estate"
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "deleted_at"
  end

  create_table "coc_skill_sets", force: :cascade do |t|
    t.string   "skill_occupation"
    t.integer  "accounting"
    t.integer  "anthropology"
    t.integer  "archaeology"
    t.integer  "astronomy"
    t.integer  "bargain"
    t.integer  "biology"
    t.integer  "chemistry"
    t.integer  "climb"
    t.integer  "conceal"
    t.integer  "credit_rating"
    t.integer  "cthulhu_mythos"
    t.integer  "disguise"
    t.integer  "dodge"
    t.integer  "drive_auto"
    t.integer  "electrical_repair"
    t.integer  "fast_talk"
    t.integer  "first_aid"
    t.integer  "geology"
    t.integer  "hide"
    t.integer  "history"
    t.integer  "jump"
    t.integer  "law"
    t.integer  "library_use"
    t.integer  "listen"
    t.integer  "locksmith"
    t.integer  "martial_arts"
    t.integer  "mechanical_repair"
    t.integer  "medicine"
    t.integer  "natural_history"
    t.integer  "navigate"
    t.integer  "occult"
    t.integer  "operate_heavy_machine"
    t.integer  "own_language"
    t.integer  "persuade"
    t.integer  "pharmacy"
    t.integer  "photography"
    t.integer  "physics"
    t.integer  "psychoanalysis"
    t.integer  "psychology"
    t.integer  "ride"
    t.integer  "sneak"
    t.integer  "spot_hidden"
    t.integer  "swim"
    t.integer  "throw"
    t.integer  "track"
    t.integer  "handgun"
    t.integer  "machine_gun"
    t.integer  "rifle"
    t.integer  "shotgun"
    t.integer  "SMG"
    t.integer  "fist"
    t.integer  "grapple"
    t.integer  "head"
    t.integer  "kick"
    t.integer  "melee"
    t.text     "art"
    t.text     "craft"
    t.text     "other_language"
    t.text     "pilot"
    t.text     "other"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "occupation_skills"
  end

  create_table "dg_campaigns", force: :cascade do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dg_characters", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "alias"
    t.string   "profession"
    t.string   "employer"
    t.string   "nationality"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "education_and_occupational_history"
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bonds",                              default: [], array: true
  end

  add_index "dg_characters", ["campaign_id"], name: "index_dg_characters_on_campaign_id", using: :btree
  add_index "dg_characters", ["user_id"], name: "index_dg_characters_on_user_id", using: :btree

  create_table "dg_skill_sets", force: :cascade do |t|
    t.integer  "accounting"
    t.integer  "alertness"
    t.integer  "anthropology"
    t.integer  "archeology"
    t.integer  "art_1"
    t.integer  "art_2"
    t.integer  "art_3"
    t.string   "art_1_text"
    t.string   "art_2_text"
    t.string   "art_3_text"
    t.integer  "artillery"
    t.integer  "athletics"
    t.integer  "bureaucracy"
    t.integer  "computer_science"
    t.integer  "craft_1"
    t.integer  "craft_2"
    t.integer  "craft_3"
    t.string   "craft_1_text"
    t.string   "craft_2_text"
    t.string   "craft_3_text"
    t.integer  "criminology"
    t.integer  "demolitions"
    t.integer  "disguise"
    t.integer  "dodge"
    t.integer  "drive"
    t.integer  "firearms"
    t.integer  "first_aid"
    t.integer  "forensics"
    t.integer  "humint"
    t.integer  "heavy_machinery"
    t.integer  "heavy_weapons"
    t.integer  "history"
    t.integer  "law"
    t.integer  "medicine"
    t.integer  "melee_weapons"
    t.integer  "military_science_1"
    t.integer  "military_science_2"
    t.integer  "military_science_3"
    t.string   "military_science_1_text"
    t.string   "military_science_2_text"
    t.string   "military_science_3_text"
    t.integer  "navigate"
    t.integer  "occult"
    t.integer  "persuade"
    t.integer  "pharmacy"
    t.integer  "pilot_1"
    t.integer  "pilot_2"
    t.integer  "pilot_3"
    t.string   "pilot_1_text"
    t.string   "pilot_2_text"
    t.string   "pilot_3_text"
    t.integer  "psychotherapy"
    t.integer  "ride"
    t.integer  "sigint"
    t.integer  "science_1"
    t.integer  "science_2"
    t.integer  "science_3"
    t.string   "science_1_text"
    t.string   "science_2_text"
    t.string   "science_3_text"
    t.integer  "search"
    t.integer  "stealth"
    t.integer  "surgery"
    t.integer  "survival"
    t.integer  "swim"
    t.integer  "unarmed_combat"
    t.integer  "unnatural"
    t.integer  "foreign_language_1"
    t.integer  "foreign_language_2"
    t.integer  "foreign_language_3"
    t.string   "foreign_language_1_text"
    t.string   "foreign_language_2_text"
    t.string   "foreign_language_3_text"
    t.integer  "character_id"
    t.string   "occupation"
    t.integer  "bonds"
    t.string   "bonus_skill_package"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.jsonb    "occupation_options"
    t.jsonb    "bonus_skill_package_options"
  end

  create_table "dg_statistic_sets", force: :cascade do |t|
    t.integer  "strength"
    t.integer  "constitution"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "power"
    t.integer  "charisma"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "first_name"
    t.text     "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "coc_campaigns", "users", column: "owner_id"
  add_foreign_key "dg_campaigns", "users", column: "owner_id"
end
