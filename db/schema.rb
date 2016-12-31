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

ActiveRecord::Schema.define(version: 20161230181155) do

  create_table "actividads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.float    "esfuerzo",    limit: 24
    t.integer  "rol"
    t.boolean  "finalizado"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "proyecto_id"
    t.string   "anteriores"
    t.index ["proyecto_id"], name: "index_actividads_on_proyecto_id", using: :btree
  end

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

  create_table "categoria_empleados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "nivel"
    t.string   "categoria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "estado_tarea_personals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periodo_vacacionals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "empleado_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["empleado_id"], name: "index_periodo_vacacionals_on_empleado_id", using: :btree
  end

  create_table "proyectos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "finalizado",   default: false
  end

  create_table "tarea_personals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "empleado_id"
    t.integer  "actividad_id"
    t.integer  "tipo"
    t.string   "descripcion"
    t.integer  "estado"
    t.time     "tiempo_estimado"
    t.time     "tiempo_final"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["actividad_id"], name: "index_tarea_personals_on_actividad_id", using: :btree
    t.index ["empleado_id"], name: "index_tarea_personals_on_empleado_id", using: :btree
  end

  create_table "tipo_tarea_personals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "actividads", "proyectos"
end
