require 'time'
require 'date'
class ProyectosController < ApplicationController

  # Obtiene todos los proyectos de la aplicacion
  def index
    @user = current_user
    if !@user
      @proyectos = Proyecto.all
    else
      @proyectos = @user.asignacion_proyectos.includes(:proyecto)
    end
  end

  # La vista no necesita ningun parametro
  def new
  end

  # Borra un proyecto de la aplicacion
  def delete
    Proyecto.destroy(params[:id])
    redirect_to proyectos_path
  end

  # Crea un proyecto, comprueba que no se cree en el pasado y que no exista
  # otro proyecto con el mismo nombre
  def create
    projParams = params[:session]
    @errors = ""

    start_date = projParams[:startDate]

    begin
    DateTime.parse start_date
    rescue
      @errors = 'Fecha incorrecta'
      return
    end

    if (DateTime.parse start_date) < DateTime.now.to_date
      @errors = 'Fecha incorrecta'
      return
    end

    proyecto = Proyecto.find_by(
      nombre: projParams[:name],
      fecha_inicio: projParams[:startDate])

    if !proyecto
      Proyecto.create(nombre: projParams[:name], fecha_inicio: projParams[:startDate])
      redirect_to proyectos_path and return
    else
      @errors = 'El proyecto ya existe'
    end
  end

  # Lista todos los proyectos
  def all
      @proyectos = Proyecto.all
  end

  # Para asignar un jefe de proyecto de necesita la id del proyecto
  def setmanager
        @id_project = params[:id]
  end

  # Asigna un empleado al proyecto, comprueba que tiene la categoria y que no
  # tiene mas proyectos asignados de los que puede tener
  def setmanagerforproject
    @errors = ""
    manager_username = params[:session][:username]
    project_id = params[:id]

    manager = Empleado.find_by(usuario: manager_username)

    if !manager
      @errors = "el usuario no existe"
      return
    elsif manager.categoria != 1
      @errors = "el empleado no tiene categoría suficiente para ser jefe de proyecto"
      return
    end

    manager_projects = manager.asignacion_proyectos.joins(:proyecto).where(rol: 1).where("finalizado = ?", false).count

    if manager_projects == 0
      proyecto = Proyecto.find_by(id: project_id)
      AsignacionProyecto.create(empleado_id: manager.id, proyecto_id: project_id, rol: 1, participacion: 0)
      redirect_to proyectos_path and return
    else
      @errors = "ya es jefe de proyecto en otro proyecto actualmente"
      return
    end
  end

  # Modo edicion del proyecto, solo para jefes de proyecto, devuelve a la vista
  # el proyecto en cuestion
  def edit
    @proyecto = Proyecto.find(params[:id])
  end

  # Inicia el proyecto, con el dia de inicio, se encarga de calcular la duracion
  # del proyecto completo
  def init
    @proyecto = Proyecto.find(params[:id])
    @proyecto.iniciar_proyecto(params[:proyecto][:fecha_inicio].to_time)

    end_time = @proyecto.actividads.order(end_time: :desc).first.end_time

    @proyecto.update(
        fecha_inicio: params[:proyecto][:fecha_inicio].to_time,
        fecha_fin: end_time
    )
    redirect_to empleado_proyectos_path(Empleado.find_by(id: session[:user_id]))
  end

  # Muestra la informacion del proyecto, la vista se encarga de gestionar que
  # puede ver cada empleado
  def show
    @proyecto = Proyecto.find(params[:id])
    @asignacion = AsignacionProyecto.where(empleado_id: current_user.id)
        .where(proyecto_id: @proyecto.id).first
  end
end
