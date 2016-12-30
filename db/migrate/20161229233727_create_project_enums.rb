class CreateProjectEnums < ActiveRecord::Migration[5.0]
  def change
    create_table :estado_tarea_personals do |t|
        t.string :estado

        t.timestamps
    end

    create_table :tipo_tarea_personals do |t|
        t.string :tipo

        t.timestamps
    end

    create_table :categoria_empleados do |t|
        t.integer :nivel
        t.string :categoria

        t.timestamps
    end
  end
end
