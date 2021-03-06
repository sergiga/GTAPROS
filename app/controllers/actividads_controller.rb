class ActividadsController < ApplicationController

  # Obtiene el proyecto pasado por parametros y prepara una actividad
  # para que pueda ser utilizada en un formulario
  def new
    @proyecto = Proyecto.find(params[:proyecto_id])
    @actividad = Actividad.new
  end

  # Crea una nueva actividad si cumple las condiciones, es decir, las predecesoras
  # existen y no existe una actividad en ese proyecto con el mismo nombre
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

  # Obtiene la actividad a la que se va a asignar un nuevo empleados
  # y obtiene los empleados que pueden ser elegidos para esa actividad
  def setempleadonew
    @actividad = Actividad.find(params[:id])
    @empleados = Empleado.find_candidatos_asignacion(@actividad)
  end

  # Crea una nueva asignacion de eactividad entre una actividad y
  # un empleados. Al cambiar el esfuerzo de la actividad por el hecho de
  # ponerle un empleado mas, tambien se recalcula la duracion del proyecto
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

  # Para evitar inyeccion de scripts maliciosos en los formularios
  def asignacion_params
    params.require(:asignacion).permit(:empleado_id)
  end

  # Para evitar inyeccion de scripts maliciosos en los formularios
  def actividad_params
    params.require(:actividad).permit(:nombre, :descripcion, :esfuerzo, :anteriores, :rol)
  end
end
