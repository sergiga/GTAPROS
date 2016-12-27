class AddIndexToEmpleadosUsuario < ActiveRecord::Migration[5.0]
  def change
      add_index :empleados, :usuario, unique: true
  end
end
