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

ActiveRecord::Schema.define(:version => 20110803181705) do

  create_table "addresses", :force => true do |t|
    t.integer  "company_id"
    t.boolean  "main",       :default => false
    t.string   "street"
    t.string   "city"
    t.string   "plz"
    t.string   "country"
    t.float    "lng"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "associations", :force => true do |t|
    t.integer  "company_id"
    t.integer  "associate_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "permalink"
    t.string   "name"
    t.text     "teaser"
    t.text     "history"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "twitter"
    t.string   "website"
    t.integer  "staff"
    t.integer  "sector_id"
    t.integer  "requests_count",  :default => 0,     :null => false
    t.integer  "leads_count",     :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "logo_processing", :default => false
    t.string   "logo"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feed_items", :force => true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "feed_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leads", :force => true do |t|
    t.integer  "company_id"
    t.integer  "request_id"
    t.integer  "source_id"
    t.string   "status",     :default => "new"
    t.integer  "weight",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.boolean  "read",         :default => false
    t.boolean  "deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.string   "schedule",        :default => "weekly"
    t.datetime "delivered_at"
    t.string   "status",          :default => "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.integer  "tags"
    t.integer  "leads"
    t.integer  "requests"
    t.boolean  "notify"
    t.string   "name"
    t.string   "cheddarcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_suggestions", :force => true do |t|
    t.string   "price"
    t.string   "plan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "company_id"
    t.datetime "duedate"
    t.integer  "budget",      :default => 0
    t.string   "area_filter", :default => "everywhere"
    t.string   "distance",    :default => "0"
    t.string   "language",    :default => "DE"
    t.string   "status",      :default => "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.integer  "company_id"
    t.string   "twitter_access_token"
    t.string   "twitter_access_secret"
    t.boolean  "default_twitter_send",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "company_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "updates", :force => true do |t|
    t.integer  "company_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "twitter",    :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "language"
    t.string   "function"
    t.integer  "company_id"
    t.string   "phone"
    t.string   "xing"
    t.string   "fb"
    t.string   "twitter"
    t.string   "skype"
    t.boolean  "admin",                  :default => false
    t.date     "since"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notify",                 :default => "weekly"
    t.integer  "notifiers_mask",         :default => 7
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
