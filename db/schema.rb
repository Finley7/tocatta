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

ActiveRecord::Schema.define(version: 20161116204435) do

  create_table "forums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_subforum"
    t.integer  "section_id"
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "permissions_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id",       null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree
  end

  create_table "replies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "topic_id",                                 null: false
    t.integer  "author_id",                                null: false
    t.integer  "edit_by"
    t.text     "body",       limit: 65535,                 null: false
    t.boolean  "deleted",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "description"
    t.boolean "banned"
    t.integer "post_delay"
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id", using: :btree
    t.index ["user_id"], name: "index_roles_users_on_user_id", using: :btree
  end

  create_table "sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "forum_id",                    null: false
    t.integer  "author_id",                   null: false
    t.integer  "lastposter_id",               null: false
    t.datetime "lastpost_date",               null: false
    t.integer  "edit_by"
    t.boolean  "closed"
    t.string   "title",                       null: false
    t.string   "slug",                        null: false
    t.text     "body",          limit: 65535, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["author_id"], name: "threads_author_id_fk", using: :btree
    t.index ["edit_by"], name: "threads_editor_id_fk", using: :btree
    t.index ["forum_id"], name: "threads_forums_id_fk", using: :btree
    t.index ["lastposter_id"], name: "threads_lastposter_id_fk", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "email",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "primary_role"
  end

  add_foreign_key "topics", "forums", name: "threads_forums_id_fk"
  add_foreign_key "topics", "users", column: "author_id", name: "threads_author_id_fk"
  add_foreign_key "topics", "users", column: "edit_by", name: "threads_editor_id_fk"
  add_foreign_key "topics", "users", column: "lastposter_id", name: "threads_lastposter_id_fk"
end
