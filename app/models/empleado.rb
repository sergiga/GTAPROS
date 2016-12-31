class Empleado < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :proyectos, through: :asignacion_proyectos

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

    def full_name
      "#{nombre} #{apellidos}"
    end
end
