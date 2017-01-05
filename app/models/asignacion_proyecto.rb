class AsignacionProyecto < ApplicationRecord
    belongs_to :empleado
    belongs_to :proyecto

    validate :rol_no_puede_ser_mayor
    validates :participacion, presence: true
    validates :rol, presence: true

    # Valida la creacion de la asignacion si el rol esta dentro de
    # la categoria del empleado
    def rol_no_puede_ser_mayor
      if empleado.categoria > rol
        errors.add(:rol, "no puede ser mayor")
      end
    end
end
