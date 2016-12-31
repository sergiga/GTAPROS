class Proyecto < ApplicationRecord
    has_many :asignacion_proyectos
    has_many :actividads
end
