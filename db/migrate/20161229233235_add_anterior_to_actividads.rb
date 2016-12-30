class AddAnteriorToActividads < ActiveRecord::Migration[5.0]
    def change
        add_column :actividads, :anteriores, :string
    end
end
