class AddEsferzoTotalToActividad < ActiveRecord::Migration[5.0]
  def change
    add_column :actividads, :participacion, :float, default: 0.0
  end
end
