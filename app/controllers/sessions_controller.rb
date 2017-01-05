class SessionsController < ApplicationController
    layout "login"

    # Esta vacio ya que no es necesaria ninguna informacion
    # en la vista
    def new
    end

    # Crea una sesion para el usuario introducido, si los credenciales no
    # son correctos o el usuario no existe, nos devuelve a la pagina de
    # login
    def create
        user = Empleado.find_by(usuario: params[:session][:usuario].downcase)
        if !user
            flash.now['not_user'] = 'Usuario no existe'
            render 'new'
        elsif user.authenticate(params[:session][:password])
            log_in user
            if user.categoria == 0
                redirect_to empleados_path if user.categoria == 0
            else
                redirect_to empleado_proyectos_path(user)
            end
        else
            flash.now['not_pass'] = 'Password incorrecto'
            render 'new'
        end
    end

    # Desconexion de un usuario, elimina la sesion y nos lleva a la pagina de
    # login
    def destroy
        log_out
        redirect_to root_url
    end
end
