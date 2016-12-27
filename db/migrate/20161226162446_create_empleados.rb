class CreateEmpleados < ActiveRecord::Migration[5.0]
  def change
    create_table :empleados do |t|
      t.string :nombre
      t.string :apellidos
      t.string :usuario
      t.string :password
      t.integer :categoria

      t.timestamps
    end
  end
end
