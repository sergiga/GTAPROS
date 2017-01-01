class AsignacionActividad < ApplicationRecord
  belongs_to :empleado
  belongs_to :actividad
end
