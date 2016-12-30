class ProyectosController < ApplicationController
  
  def index
    @proyectos = Proyecto.all
  end

  def new
  end

  def delete
    Proyecto.destroy(params[:id])
    redirect_to proyectos_path
  end

  def create
    projParams = params[:session]
    @errors = ""

    if ((DateTime.parse(projParams[:startDate]) rescue ArgumentError) == ArgumentError)
      @errors = 'Fecha incorrecta'
      #TODO error si el formato de la fecha es incorrecto
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

  def all
      @proyectos = Proyecto.all
  end

  def setmanager
        @id_project = params[:id]
  end

  def setmanagerforproject
    @errors = ""
    manager_username = params[:session][:username]
    project_id = params[:id]
    puts "project_id ==>> " + project_id

    manager = Empleado.find_by(usuario: manager_username)

    if !manager
      #TODO error no existe el usuario
      @errors = "el unuario no existe"
      return
    elsif manager.categoria != 1
      #TODO el empleado no tiene categoria para ser jefe de proyecto
      @errors = "el empleado no tiene categoría suficiente para ser jefe de proyecto"
      return
    end 

    projects_assigned_to_manager = AsignacionProyecto.find_by(empleado_id: manager.id, rol: 1)

    if !projects_assigned_to_manager
      puts "se crea"
      proyecto = Proyecto.find_by(id: project_id)
      AsignacionProyecto.create(empleado_id: manager.id, proyecto_id: project_id, rol: 1, participacion: 35)
      redirect_to proyectos_path and return
    else
      #TODO el empleado ya tiene asignado en esas fechas un proyecto
      @errors = "ya es jefe de proyecto de otro proyecto"
    end
  end
end