class CreateAsignacionActividads < ActiveRecord::Migration[5.0]
  def change
    create_table :asignacion_actividads do |t|
      t.belongs_to :empleado, index: true
      t.belongs_to :actividad, index: true

      t.timestamps
    end
  end
end
