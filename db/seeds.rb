# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#                ENUMS               #

EstadoTareaPersonal.create(estado: "Aceptada")
EstadoTareaPersonal.create(estado: "Pendiente")
EstadoTareaPersonal.create(estado: "Rechazada")

CategoriaEmpleado.create(nivel: 1, categoria: "Jefe Proyecto")
CategoriaEmpleado.create(nivel: 2, categoria: "Analista")
CategoriaEmpleado.create(nivel: 3, categoria: "Diseniador")
CategoriaEmpleado.create(nivel: 3, categoria: "Analista Programador")
CategoriaEmpleado.create(nivel: 3, categoria: "Responsable Pruebas")
CategoriaEmpleado.create(nivel: 4, categoria: "Programador")
CategoriaEmpleado.create(nivel: 4, categoria: "Probador")

TipoTareaPersonal.create(tipo: "Trato Usuarios")
TipoTareaPersonal.create(tipo: "Reunion")
TipoTareaPersonal.create(tipo: "Revision")
TipoTareaPersonal.create(tipo: "Documentacion")
TipoTareaPersonal.create(tipo: "Desarrollo")
TipoTareaPersonal.create(tipo: "Formacion")

#              EMPLEADOS             #

Empleado.create(nombre: "Pablo", apellidos: "de la Fuente",
        usuario: "admin", password: "admin", password_confirmation: "admin",
        categoria: 0)

Empleado.create(nombre: "Sergio", apellidos: "Garcia Villanueva",
        usuario: "sergiga", password: "1234", password_confirmation: "1234",
        categoria: 1)
