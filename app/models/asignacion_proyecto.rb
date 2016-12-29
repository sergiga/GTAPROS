class AsignacionProyecto < ApplicationRecord
    belongs_to :empleado
    belongs_to :proyecto
end
