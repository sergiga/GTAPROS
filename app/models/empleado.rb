class Empleado < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :asignacion_actividads
    has_many :periodo_vacacionals
    has_many :tarea_personals
    has_many :proyectos, through: :asignacion_proyectos
    has_many :actividads, through: :asignacion_actividads

    before_save { self.usuario = usuario.downcase }
    validates :usuario, presence: true, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true

    def self.asignables(proyecto)
      asignables = []
      Empleado.all.each do |e|
        acumulado = 0
        if e.proyectos.where(finalizado: false).count < 2
          if e.categoria != 0 && proyecto.empleados.find_by(id: e.id).nil?
            e.asignacion_proyectos.joins(:proyecto).each do |a|
              acumulado += a.participacion unless a.proyecto.finalizado
            end
            if acumulado < 100
              asignables << e
            end
          end
        end
      end
      asignables
    end

    def self.find_candidatos_asignacion(actividad)
      candidatos = []

      empleados = actividad.proyecto.empleados
      empleados.each do |e|
        # No tiene mas de 4 actividades en ese periodo
        asignadas_durante = e.actividads
            .where('start_time <= ?', actividad.end_time)
            .where('end_time >= ?', actividad.start_time)
            .count

        # No tiene vacaciones en ese periodo
        vacaciones = e.periodo_vacacionals
            .where('start_time <= ?', actividad.end_time)
            .where('end_time >= ?', actividad.start_time)
            .count

        # Tiene la cateogoria necesaria
        categoria = AsignacionProyecto.find_by(empleado_id: e.id, proyecto_id: actividad.proyecto_id).rol

        if  (
            (e.actividads.where(nombre: actividad.nombre).where(proyecto_id: actividad.proyecto_id).count == 0) &&
            (asignadas_durante < 4) &&
            (vacaciones == 0) &&
            (categoria <= actividad.rol)
            #(categoria) != 1
            )
          candidatos << e
        end
      end

      candidatos
    end

    def full_name
      "#{nombre} #{apellidos}"
    end
end
