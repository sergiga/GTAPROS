class EmpleadosController < ApplicationController

    layout 'layouts/new_employee'

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
          flash[:notice] = "Successfully created..."
       else 
         flash[:notice] = "This user already exists in system"
        
       end
    end

end
