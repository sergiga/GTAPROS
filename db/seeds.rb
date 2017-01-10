CategoriaEmpleado.create!([
  {nivel: 1, categoria: "Jefe Proyecto"},
  {nivel: 2, categoria: "Analista"},
  {nivel: 3, categoria: "Diseniador"},
  {nivel: 3, categoria: "Analista Programador"},
  {nivel: 3, categoria: "Responsable Pruebas"},
  {nivel: 4, categoria: "Programador"},
  {nivel: 4, categoria: "Probador"}
])
Empleado.create!([
  {nombre: "Pablo", apellidos: "de la Fuente", usuario: "admin", password: "admin", password_confirmation: "admin", categoria: 0},
  {nombre: "Sergio", apellidos: "Garcia Villanueva", usuario: "sergiga", password: "1234", password_confirmation: "1234", categoria: 1},
  {nombre: "Pablo", apellidos: "Carrascal Muñoz", usuario: "desarrollador", password: "1234", password_confirmation: "1234", categoria: 2}
])
EstadoTareaPersonal.create!([
  {estado: "Aceptada"},
  {estado: "Pendiente"},
  {estado: "Rechazada"}
])
PeriodoVacacional.create!([
  {empleado_id: 3, start_time: "2017-03-08 23:00:00", end_time: "2017-03-22 23:00:00"}
])
Proyecto.create!([
  {nombre: "Prueba 1", fecha_inicio: "2017-06-10 22:00:00", fecha_fin: "2017-06-22 13:00:00", finalizado: false},
  {nombre: "Prueba 2", fecha_inicio: "2017-02-23 00:00:00", fecha_fin: nil, finalizado: false}
])
TipoTareaPersonal.create!([
  {tipo: "Trato Usuarios"},
  {tipo: "Reunion"},
  {tipo: "Revision"},
  {tipo: "Documentacion"},
  {tipo: "Desarrollo"},
  {tipo: "Formacion"}
])
Actividad.create!([
  {nombre: "A", descripcion: "Prueba A", esfuerzo: 34.0, rol: 6, finalizado: nil, start_time: "2017-06-12 07:00:00", end_time: "2017-06-16 09:00:00", proyecto_id: 1, anteriores: "", participacion: 0.0},
  {nombre: "B", descripcion: "Prueba B", esfuerzo: 12.0, rol: 6, finalizado: nil, start_time: "2017-06-16 09:00:00", end_time: "2017-06-19 13:00:00", proyecto_id: 1, anteriores: "A", participacion: 0.0},
  {nombre: "C", descripcion: "Prueba C", esfuerzo: 24.0, rol: 6, finalizado: nil, start_time: "2017-06-16 09:00:00", end_time: "2017-06-23 17:00:00", proyecto_id: 1, anteriores: "A", participacion: 0.5},
  {nombre: "D", descripcion: "Prueba D", esfuerzo: 12.0, rol: 6, finalizado: nil, start_time: "2017-06-23 17:00:00", end_time: "2017-06-27 13:00:00", proyecto_id: 1, anteriores: "B,C", participacion: 0.0}
])
AsignacionActividad.create!([
  {empleado_id: 3, actividad_id: 3}
])
AsignacionProyecto.create!([
  {empleado_id: 2, proyecto_id: 1, rol: 1, participacion: 0.0},
  {empleado_id: 3, proyecto_id: 1, rol: 3, participacion: 50.0}
])
