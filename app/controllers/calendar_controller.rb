class CalendarController < ApplicationController

  # Carga la pagina principal del calendario
  def index
  end

  # Pide vacaciones en funcion de una fecha inicial y un
  # numero de semanas
  def pedirvacaciones

    if !vacaciones_params[:start_time].empty? && !vacaciones_params[:semanas].empty?
      inicio_periodo = vacaciones_params[:start_time].to_time
      semanas = vacaciones_params[:semanas]
      final_periodo = inicio_periodo + semanas.to_i.weeks

      @vacaciones = PeriodoVacacional.create(
        empleado_id: params[:id],
        start_time: inicio_periodo,
        end_time: final_periodo
      )

      if @vacaciones.new_record?
        flash.now[:errors] = @vacaciones.errors.full_messages.to_sentence
        render 'index'
      else
        render 'index'
      end
    else
      flash.now[:errors] = "Formularios vacios"
      render 'index'
    end
  end

  # Muestra todas las actividades que tiene el empleado
  # especificado por la url (params) y devuelve un JSON,
  # solo acepta llamadas AJAX
  def actividades
    empleado = Empleado.includes(:actividads).find(params[:id])
    @actividades = empleado.actividads
        .where("start_time <= ?", params[:end])
        .where("end_time >= ?", params[:start])

    render :json => @actividades.as_json
  end

  # Muestra todas las vacaciones que tiene el empleado
  # especificado por la url (params) y devuelve un JSON,
  # solo acepta llamadas AJAX
  def vacaciones
    empleado = Empleado.includes(:periodo_vacacionals).find(params[:id])
    @vacaciones = empleado.periodo_vacacionals
        .where("start_time <= ?", params[:end])
        .where("end_time >= ?", params[:start])

    render :json => @vacaciones.as_json
  end

  # Por seguridad evitamos inyeccion de codigo malicioso por
  # los formularios
  def vacaciones_params
    params.require(:vacaciones).permit(:start_time, :semanas)
  end
end
