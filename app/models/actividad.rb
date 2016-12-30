class Actividad < ApplicationRecord
    has_many :tarea_personals
    has_many :proyectos
end
