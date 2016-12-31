class Proyecto < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :actividads
    has_many :empleados, through: :asignacion_proyectos
end
