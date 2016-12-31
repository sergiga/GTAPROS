class Actividad < ApplicationRecord
    has_many :tarea_personals
    belongs_to :proyecto

    validates :nombre, presence: true
    validates :descripcion, presence: true
    validates :esfuerzo, presence: true
    validates :rol, presence: true
end
