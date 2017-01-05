class Actividad < ApplicationRecord
  belongs_to :proyecto
  has_many :tarea_personals
  has_many :asignacion_actividads
  has_many :empleados, through: :asignacion_actividads

  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :esfuerzo, presence: true
  validates :rol, presence: true

  # Calcula la duracion de la actividad y recursivamente la de sus hijas, este
  # metodo solo funciona cuando no se sabe aun la duracion de la actividad, es
  # decir, cuando se calcula por primera vez
  def calcular_tiempo(actividades, fecha_inicio)
    if self.start_time.nil? || self.end_time.nil? || self.start_time < fecha_inicio.ctime
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

  # Recalcula la duracion de la actividad y recursivamente la de sus hijas
  # cuando se asigna un nuevo trabajador a la actividad y por ello cambia la
  # duracion de la actividad
  def recalcular_tiempo(e_participacion, actividades)
    latest_start = self.proyecto.fecha_inicio
    self.participacion += (e_participacion / 100)

    latest_start = self.start_time if anteriores.split(/\s*,\s*/).count == 0
    anteriores.split(/\s*,\s*/).each do |ant|
      a = Actividad.find_by(nombre: ant)
      latest_start = a.end_time if a.end_time > latest_start
    end

    participacion_total = self.participacion == 0 ? 1.0 : self.participacion

    self.start_time = latest_start
    self.end_time = (esfuerzo/participacion_total).to_i.business_hour.after(self.start_time)

    debugger

    update(
      start_time: self.start_time,
      end_time: self.end_time,
      participacion: self.participacion
    )

    actividades.each do |a|
      if a.is_child_of(nombre)
        a.recalcular_tiempo(0, actividades)
      end
    end
  end

  # Devuelve true si la actividad es hija del padre especificado en los
  # argumentos
  def is_child_of(nombre_padre)
    anteriores.split(/\s*,\s*/).each do |a|
      return true if a == nombre_padre
    end
    false
  end

  # Override al metodo que transforma el objecto en JSON, se utiliza params
  # enviar el JSON necesario para el calendario
  def as_json(options = {})
    {
    title: "#{self.proyecto.nombre} - #{self.nombre}",
    start: self.start_time,
    end: self.end_time
    }
  end
end
