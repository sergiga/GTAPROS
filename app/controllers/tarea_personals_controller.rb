class TareaPersonalsController < ApplicationController
	def new
		@tarea = TareaPersonal.new
	end


	def create

		@actividad = Actividad.find(params[:actividad_id])
		@tarea = @actividad.tarea_personals.new(tarea_params)
		@tarea.empleado_id = current_user.id
		@tarea.save
		if @tarea.new_record?
			flash[:notice] = "Error en la creacion"
			render 'new'
		else
			redirect_to actividad_path(params[:actividad_id])
		end
	end

	def tarea_params
		params[:tarea].permit(:tipo, :duracion, :descripcion)
	end

	def show 
		@actividad = Actividad.find(params[:actividads_id])
    @tareas = TareaPersonal.where(:actividad_id => @actividad.id)

	end
end