require 'time'
require 'date'
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

    manager = Empleado.find_by(usuario: manager_username)

    if !manager
      @errors = "el unuario no existe"
      return
    elsif manager.categoria != 1
      @errors = "el empleado no tiene categoría suficiente para ser jefe de proyecto"
      return
    end 

    projects_assigned_to_manager = AsignacionProyecto.joins(:proyecto).where(empleado_id: manager.id, rol: 1).
                                                  where("fecha_inicio < ?", DateTime.now.to_date).
                                                  where("fecha_fin > ?", DateTime.now.to_date)
                                              
    if !projects_assigned_to_manager
      puts "se crea"
      proyecto = Proyecto.find_by(id: project_id)
      AsignacionProyecto.create(empleado_id: manager.id, proyecto_id: project_id, rol: 1, participacion: 35)
      redirect_to proyectos_path and return
    else
      @errors = "ya es jefe de proyecto de otro proyecto"
    end
  end
end