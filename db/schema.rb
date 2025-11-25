# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_20_150733) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bakeries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "bakery_users", force: :cascade do |t|
    t.bigint "bakery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["bakery_id", "user_id"], name: "index_bakery_users_on_bakery_id_and_user_id", unique: true
    t.index ["bakery_id"], name: "index_bakery_users_on_bakery_id"
    t.index ["user_id"], name: "index_bakery_users_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.bigint "warehouse_id", null: false
    t.index ["warehouse_id"], name: "index_products_on_warehouse_id"
  end

  create_table "purchase_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.bigint "product_id", null: false
    t.bigint "purchase_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.bigint "warehouse_id", null: false
    t.index ["product_id"], name: "index_purchase_items_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_items_on_purchase_id"
    t.index ["warehouse_id"], name: "index_purchase_items_on_warehouse_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "purchase_date"
    t.datetime "updated_at", null: false
  end

  create_table "request_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.bigint "request_id", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_request_items_on_product_id"
    t.index ["request_id"], name: "index_request_items_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "bakery_id", null: false
    t.datetime "created_at", null: false
    t.date "request_date"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["bakery_id"], name: "index_requests_on_bakery_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "password_digest", null: false
    t.string "phone", null: false
    t.string "role", default: "worker", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bakery_users", "bakeries"
  add_foreign_key "bakery_users", "users"
  add_foreign_key "products", "warehouses"
  add_foreign_key "purchase_items", "products"
  add_foreign_key "purchase_items", "purchases"
  add_foreign_key "purchase_items", "warehouses"
  add_foreign_key "request_items", "products"
  add_foreign_key "request_items", "requests"
  add_foreign_key "requests", "bakeries"
  add_foreign_key "requests", "users"
end
