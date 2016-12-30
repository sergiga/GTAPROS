class CreateTareaPersonals < ActiveRecord::Migration[5.0]
    def change
        create_table :actividads do |t|
            t.string :nombre
            t.string :descripcion
            t.float :esfuerzo
            t.integer :rol
            t.boolean :finalizado
            t.datetime :start_time
            t.datetime :end_time
            t.integer :actividad_anterior_id

            t.timestamps
        end

        create_table :tarea_personals do |t|
            t.belongs_to :empleado, index: true
            t.belongs_to :actividad, index: true
            t.integer :tipo
            t.string :descripcion
            t.integer :estado
            t.time :tiempo_estimado
            t.time :tiempo_final

            t.timestamps
        end

        create_table :periodo_vacacionals do |t|
            t.belongs_to :empleado, index: true
            t.datetime :start_time
            t.datetime :end_time

            t.timestamps
        end
    end
end
