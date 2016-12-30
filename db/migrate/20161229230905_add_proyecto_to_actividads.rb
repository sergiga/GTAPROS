class AddProyectoToActividads < ActiveRecord::Migration[5.0]
  def change
      add_reference :actividads, :proyecto, index: true
      add_foreign_key :actividads, :proyectos
  end
end
