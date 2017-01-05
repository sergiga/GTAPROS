class Proyecto < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :actividads
    has_many :empleados, through: :asignacion_proyectos

    validates :nombre, presence: true, uniqueness: { case_sensitive: false }

    # Inicia el proyecto el dia especificado y calcula la duracion del mismo
    # en funcion de las actividades, sus esfuerzos y sus predecesoras
    def iniciar_proyecto(start_time)
      iniciales = actividads.where(anteriores: "")
      iniciales.each do |i|
        i.calcular_tiempo(actividads, start_time)
      end
    end
end
