class AddPasswordDigestToEmpleados < ActiveRecord::Migration[5.0]
  def change
    add_column :empleados, :password_digest, :string
  end
end
