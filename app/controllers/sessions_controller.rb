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
            redirect_to pages_main_path
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
