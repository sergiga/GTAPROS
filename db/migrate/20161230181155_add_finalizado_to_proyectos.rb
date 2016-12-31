class AddFinalizadoToProyectos < ActiveRecord::Migration[5.0]
  def change
    add_column :proyectos, :finalizado, :boolean, default: false
  end
end
