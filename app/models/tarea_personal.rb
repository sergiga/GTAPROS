class TareaPersonal < ApplicationRecord
    belongs_to :empleado
    belongs_to :actividad

    validates :descripcion, presence: true
    
end
