class SessionsController < ApplicationController
    layout "login"

    def new
    end

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

    def destroy
        log_out
        redirect_to root_url
    end
end
