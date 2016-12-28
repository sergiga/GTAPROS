class CreateAsignacionesAndProyectos < ActiveRecord::Migration[5.0]
    def change
        create_table :asignacion_proyectos do |t|
            t.belongs_to :empleado, index: true
            t.belongs_to :proyecto, index: true
            t.integer :rol
            t.float :participacion
            t.timestamps
        end

        create_table :proyectos do |t|
            t.string :nombre
            t.datetime :fecha_inicio
            t.datetime :fecha_fin
            t.timestamps
        end
    end
end
