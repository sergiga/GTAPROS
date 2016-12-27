class SessionsController < ApplicationController
    layout "login"

    def new
    end

    def create
        user = Empleado.find_by(usuario: params[:session][:usuario].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            redirect_to user
        else
            flash.now[:notice] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end
