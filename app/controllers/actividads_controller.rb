class ActividadsController < ApplicationController
  def new
    @proyecto = Proyecto.find(params[:proyecto_id])
    @actividad = Actividad.new
  end

  def create
    @proyecto = Proyecto.find(params[:proyecto_id])
    @actividad = Actividad.new(actividad_params)
    valid = true
    predecesoras = actividad_params[:anteriores].split(/\s*,\s*/)
    predecesoras.each do |p|
      if !p.empty? && @proyecto.actividads.find_by(nombre: p).nil?
        valid = false
      end
    end
    valid = false if @proyecto.actividads.find_by(nombre: actividad_params[:nombre])

    @actividad.proyecto_id = params[:proyecto_id]
    @actividad.save if valid

    if @actividad.new_record?
      flash.now[:notice] = "Error en la creacion de la actividad"
      render 'new'
    else
      redirect_to edit_proyecto_path(params[:proyecto_id])
    end
  end

  def setempleadonew
    @actividad = Actividad.find(params[:id])
    @empleados = Empleado.find_candidatos_asignacion(@actividad)
  end

  def setempleadocreate
    @actividad = Actividad
        .includes(proyecto: [:actividads])
        .find(params[:id])

    participacion = AsignacionProyecto.all
        .where(empleado_id: asignacion_params[:empleado_id])
        .where(proyecto_id: @actividad.proyecto_id)
        .first
        .participacion

    @actividad.recalcular_tiempo(
        participacion,
        @actividad.proyecto.actividads
        )

    @actividad.asignacion_actividads.create(
        empleado_id: asignacion_params[:empleado_id])

    redirect_to empleado_proyecto_path(current_user, @actividad.proyecto)
  end

  def show
    @actividad = Actividad.find(params[:id])
    @tareas = TareaPersonal.where(:actividad_id => @actividad.id)
  end

  def asignacion_params
    params.require(:asignacion).permit(:empleado_id)
  end

  def actividad_params
    params.require(:actividad).permit(:nombre, :descripcion, :esfuerzo, :anteriores, :rol)
  end
end
