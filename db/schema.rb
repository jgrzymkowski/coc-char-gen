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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130921190755) do

  create_table "characteristic_sets", :force => true do |t|
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "constitution"
    t.integer  "appearance"
    t.integer  "power"
    t.integer  "size"
    t.integer  "education"
    t.integer  "character_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "characters", :force => true do |t|
    t.string   "investigator_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "occupation"
    t.string   "degrees"
    t.string   "birthplace"
    t.string   "gender"
    t.integer  "age"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "skill_sets", :force => true do |t|
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
    t.integer  "thrown"
    t.integer  "track"
    t.integer  "handgun"
    t.integer  "machine_gun"
    t.integer  "rifle"
    t.integer  "shotgun"
    t.integer  "SMG"
    t.text     "art"
    t.text     "craft"
    t.text     "other_language"
    t.text     "pilot"
    t.text     "other"
    t.integer  "character_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

end
