class PeriodoVacacional < ApplicationRecord
  belongs_to :empleado
  has_many :periodo_vacacionals

  attr_accessor :semanas

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :puede_coger_vacaciones

  # Al crear el periodo en la DB primero comprueba que
  # no se pasa de dias, o que no le coincidan fechas
  # durante el periodo
  def puede_coger_vacaciones
    if start_time.past?
      errors.add(:pasado, ": aun no inventamos vacaciones al pasado")
    end

    if empleado.periodo_vacacionals.count > 0
      if empleado.periodo_vacacionals.count > 1
        errors.add(:periodos, ": tienes demasiados")
      else
        primer_periodo = empleado.periodo_vacacionals.first
        dias_restantes = (primer_periodo.end_time - primer_periodo.start_time).to_int
        if dias_restantes < 8
          errors.add(:dias, ": has pedido demasiados")
        end
      end

      acts_en_periodo = empleado.actividads
          .where("start_time <= ?", end_time)
          .where("end_time >= ?", start_time)
          .where(finalizado: false)
          .count

      vacs_en_periodo = empleado.periodo_vacacionals
          .where("start_time <= ?", end_time)
          .where("end_time >= ?", start_time)
          .count

      if acts_en_periodo > 0 && vacs_en_periodo > 0
        errors.add(:tareas, ": tienes tareas pendientes esas fechas")
      end
    end
  end

  def as_json(options = {})
    {
    title: "Vacaciones",
    start: self.start_time,
    end: self.end_time
    }
  end
end
