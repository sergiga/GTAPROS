class RemoveAnteriorFromActividad < ActiveRecord::Migration[5.0]
    def change
        remove_column :actividads, :actividad_anterior_id
    end
end
