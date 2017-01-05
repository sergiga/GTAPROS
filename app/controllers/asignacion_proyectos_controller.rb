class AsignacionProyectosController < ApplicationController

  # Obtiene el pryecto especificado por parametro e instancia una
  # asignacion para que la use la vista en el formulario
  def new
    @proyecto = Proyecto.find(params[:proyecto_id])
    @asignacion = AsignacionProyecto.new
  end

  # Crea la asignacion si se valida el modelo (ver models/asignacion_proyecto.rb)
  def create
    @proyecto = Proyecto.find(params[:proyecto_id])
    @asignacion = AsignacionProyecto.new(asignacion_params)
    @asignacion.proyecto_id = params[:proyecto_id]
    @asignacion.save

    if @asignacion.new_record?
      flash.now[:notice] = "Error en la asignacion de empleado"
      render 'new'
    else
      redirect_to edit_proyecto_path(params[:proyecto_id])
    end
  end

  # Evitar inyeccion de scripts malignos por url
  def asignacion_params
    params.require(:asignacion_proyecto).permit(:empleado_id, :participacion, :rol)
  end
end
