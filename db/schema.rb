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

ActiveRecord::Schema.define(:version => 0) do

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

end
