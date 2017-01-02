class Proyecto < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :actividads
    has_many :empleados, through: :asignacion_proyectos

    def iniciar_proyecto(start_time)
      iniciales = actividads.where(anteriores: "")
      iniciales.each do |i|
        i.calcular_tiempo(actividads, start_time)
      end
    end
end
