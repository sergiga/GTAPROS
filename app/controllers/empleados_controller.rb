class EmpleadosController < ApplicationController

    def new
    end

    def create
        employee = Empleado.find_by(
            nombre: params[:session][:name],
            apellidos: params[:session][:lastname],
            usuario: params[:session][:username])
        
       if !employee
           new_employee_info = params[:session]
           Empleado.create(
               nombre: new_employee_info[:name],
               apellidos: new_employee_info[:lastname],
               usuario: new_employee_info[:username],
               password: new_employee_info[:password],
               categoria: new_employee_info[:category])
        #TODO add a success message
       else 
           #TODO add a fail message
           # "Already exists this employee"
       end
    end

    def index
        @employees = Empleado.all
        render 'index'
    end

end
