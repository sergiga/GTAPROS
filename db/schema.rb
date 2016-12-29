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

ActiveRecord::Schema.define(version: 20161228205422) do

  create_table "asignacion_proyectos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "empleado_id"
    t.integer  "proyecto_id"
    t.integer  "rol"
    t.float    "participacion", limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["empleado_id"], name: "index_asignacion_proyectos_on_empleado_id", using: :btree
    t.index ["proyecto_id"], name: "index_asignacion_proyectos_on_proyecto_id", using: :btree
  end

  create_table "empleados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "usuario"
    t.string   "password"
    t.integer  "categoria"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["usuario"], name: "index_empleados_on_usuario", unique: true, using: :btree
  end

  create_table "proyectos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
