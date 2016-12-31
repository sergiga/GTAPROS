class Actividad < ApplicationRecord
    has_many :tarea_personals
    belongs_to :proyecto

    validates :nombre, presence: true
    validates :descripcion, presence: true
    validates :esfuerzo, presence: true
    validates :rol, presence: true

    def calcular_tiempo(actividades, fecha_inicio)
      if self.start_time.nil? || self.start_time < fecha_inicio.ctime
        self.start_time = 0.business_hour.after(fecha_inicio)
        self.end_time = esfuerzo.to_i.business_hour.after(fecha_inicio)
        actividades.each do |a|
          if a.is_child_of(nombre)
            a.calcular_tiempo(actividades, self.end_time)
          end
        end
      end
      update(start_time: self.start_time, end_time: self.end_time)
    end

    def is_child_of(nombre_padre)
      anteriores.split(/\s*,\s*/).each do |a|
        return true if a == nombre_padre
      end
      false
    end
end
