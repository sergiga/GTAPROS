class EmpleadosController < ApplicationController

    def new
    end

    def create
        @errors = ""

        employee = Empleado.find_by(usuario: params[:session][:username])
        
        if employee
            @errors = "El nombre de usuario ya esta asociado"
            return
        else
           !employee
           new_employee_info = params[:session]
           Empleado.create(
               nombre: new_employee_info[:name],
               apellidos: new_employee_info[:lastname],
               usuario: new_employee_info[:username],
               password: new_employee_info[:password],
               categoria: new_employee_info[:category])
            redirect_to empleados_path and return
        end
    end

    def delete
        Empleado.destroy(params[:id])
        redirect_to empleados_path and return
    end

    def index
        @empleados = Empleado.all
    end

end
