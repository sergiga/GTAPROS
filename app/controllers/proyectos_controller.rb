class ProyectosController < ApplicationController
  
  def index
    @proyectos = Proyecto.all
  end

  def new
  end

  def create
    projParams = params[:session]

    if ((DateTime.parse(projParams[:startDate]) rescue ArgumentError) == ArgumentError)
      flash.now['incorrect_date'] = 'Fecha incorrecta'
    end

    proyecto = Proyecto.find_by(
      nombre: projParams[:name],
      fecha_inicio: projParams[:startDate])

    if !proyecto
      Proyecto.create(nombre: projParams[:name], fecha_inicio: projParams[:startDate])
      redirect_to proyectos_path and return
    else
      flash.now['incorrect_project'] = 'El proyecto ya existe'
      render 'new'
    end
  end

  def all
      @proyectos = Proyecto.all
  end

  def setmanager
  end

  def setmanagerforproject
    manager_username = params[:session][:username]

    manager = Empleado.find_by(usuario: manager_username)

    if !manager
      #TODO error no existe el usuario
      puts "usuario no existe"
      return
    elsif manager.categoria != 1
      #TODO el empleado no tiene categoria para ser jefe de proyecto
      puts "no tiene la suficiente categoria"
    end 

    projects_assigned_to_manager = AsignacionProyecto.find_by(empleado_id: manager.id, rol: 1)

    if !projects_assigned_to_manager
      puts "se crea"
      proyecto = Proyecto.find_by(nombre: params[:session][:project_id])
      AsignacionProyecto.create(empleado_id: manager.id, proyecto_id: proyecto.id, rol: 1, participacion: 35)
    else
      #TODO el empleado ya tiene asignado en esas fechas un proyecto
      puts "ya es jefe de proyecto de otro proyecto"
    end
  end
  
end