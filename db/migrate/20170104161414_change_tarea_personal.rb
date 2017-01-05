class ChangeTareaPersonal < ActiveRecord::Migration[5.0]
  def change
  	remove_column :tarea_personals, :tiempo_estimado
  	remove_column :tarea_personals, :tiempo_final

  	add_column :tarea_personals, :duracion, :float

  	change_column :tarea_personals, :estado, :integer, default: 2
  end
end
