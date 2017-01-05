class TareaPersonal < ApplicationRecord
    belongs_to :empleado
    belongs_to :actividad

    validates :descripcion,:duracion, presence: true
    validates_numericality_of :duracion, greater_than: 0
    
end
