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

ActiveRecord::Schema.define(:version => 20110221234637) do

  create_table "coords", :primary_key => "ESTABLISHMENT_ID", :force => true do |t|
    t.float "lat"
    t.float "long"
  end

  add_index "coords", ["ESTABLISHMENT_ID"], :name => "ESTABLISHMENT_ID"

  create_table "dinesafe", :primary_key => "ROW_ID", :force => true do |t|
    t.integer "ESTABLISHMENT_ID"
    t.integer "INSPECTION_ID"
    t.string  "ESTABLISHMENT_NAME",          :limit => 200
    t.string  "ESTABLISHMENTTYPE",           :limit => 200
    t.string  "ESTABLISHMENT_ADDRESS",       :limit => 200
    t.string  "ESTABLISHMENT_STATUS",        :limit => 20
    t.integer "MINIMUM_INSPECTIONS_PERYEAR"
    t.text    "INFRACTION_DETAILS",          :limit => 255, :null => false
    t.date    "INSPECTION_DATE"
    t.string  "SEVERITY",                    :limit => 10
    t.text    "ACTION",                      :limit => 255
    t.text    "COURT_OUTCOME",               :limit => 255
    t.text    "AMOUNT_FINED",                :limit => 255
  end

  add_index "dinesafe", ["ESTABLISHMENT_ID"], :name => "ESTABLISHMENT_ID"

  create_table "establishments", :force => true do |t|
    t.string   "name"
    t.string   "establishment_type"
    t.string   "address"
    t.integer  "min_inspections"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "establishments", ["address"], :name => "index_establishments_on_address"

  create_table "inspections", :force => true do |t|
    t.integer  "inspection_id"
    t.integer  "establishment_id"
    t.datetime "date"
    t.string   "status"
    t.string   "infraction_details"
    t.string   "severity"
    t.string   "action"
    t.string   "court_outcome"
    t.string   "amount_fined"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["address"], :name => "index_locations_on_address"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "foursquare_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
