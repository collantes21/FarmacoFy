
import 'dart:io';

import 'package:farmacofy/BBDD/bbdd.dart';
import 'package:farmacofy/BBDD/bbdd_medicamento_old.dart';
import 'package:farmacofy/inicioSesion/pantallaLogin.dart';
import 'package:farmacofy/models/consulta_medica.dart';
import 'package:farmacofy/pages/page_listado_consultas.dart';
import 'package:farmacofy/pages/page_listado_usuarios.dart';
import 'package:farmacofy/pantallaInicial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaConsultaMedica extends StatefulWidget {
  const PaginaConsultaMedica({super.key});

  @override
  State<PaginaConsultaMedica> createState() => _PaginaConsultaMedicaState();
}

class _PaginaConsultaMedicaState extends State<PaginaConsultaMedica> {

  final _formKey = GlobalKey<FormState>(); // Llave para validar el formulario
  //final TextEditingController _check = TextEditingController();
  ConsultaMedica consultaMedica = ConsultaMedica(); // Instancia de la clase ConsultaMedica
  BaseDeDatos bdHelper = BaseDeDatos(); // Instancia de la clase BDHelper

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Permite cerrar el teclado cuando se toca fuera de un campo de texto
        FocusScope.of(context).requestFocus(FocusNode());
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('FarmacoFy'),
          backgroundColor: const Color(0xFF02A724),
          flexibleSpace: Container( //Sirve para definir el color de la barra de estado
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  
                  Color(0xFF02A724),
                  Color.fromARGB(255, 18, 240, 63),
                  Color.fromARGB(255, 11, 134, 34),
                  
                ],
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     // Acción para el botón de configuración
            //   },
            //   icon: const Icon(Icons.settings),
            // ),
          ],
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListadoConsultasMedicas()),
            );
          },
        ),
        ),
        body: SafeArea( // Evita que el contenido se dibuje debajo del notch y el sensor de huellas
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              physics: BouncingScrollPhysics(),
              children: [
                TextFormField(
                 // controller: _check,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelText: 'Especialidad médica',
              
                    hintText: 'Introduzca la especialidad médica',
                    hintStyle: TextStyle(color: Colors.grey),// Cambia el color del texto de la pista
                    
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold), // Cambia el color y el tamaño del texto de la etiqueta
                    filled: true, // Rellena el campo de entrada con el color de fondo
                    fillColor: Colors.white, // Cambia el color de fondo del campo de entrada
                    prefixIcon: Icon(Icons.medical_services, color: Colors.blue), // Añade un icono al principio del campo de entrada
                    suffixIcon: Icon(Icons.check, color: Colors.green), // Añade un icono al final del campo de entrada
                    enabledBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está habilitado
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está enfocado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo nombre no puede estar vacío';
                    }
                    return null;
                  
                  },
                  // Cuando se guarda el valor del campo de texto se asigna a la propiedad nombre de la instancia de la clase ConsultaMedica
                  onSaved: (value){
                    if(value!=null){
                        consultaMedica.especialista = value;
                    }
                    
                  
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  //controller: _check,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelText: 'Doctor',
                    hintText: 'Introduzca el nombre del doctor',
                    hintStyle: TextStyle(color: Colors.grey),// Cambia el color del texto de la pista
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold), // Cambia el color y el tamaño del texto de la etiqueta
                    filled: true, // Rellena el campo de entrada con el color de fondo
                    fillColor: Colors.white, // Cambia el color de fondo del campo de entrada
                    prefixIcon: Icon(Icons.person, color: Colors.blue), // Añade un icono al principio del campo de entrada
                    suffixIcon: Icon(Icons.check, color: Colors.green),
                     // suffixIcon: _check.text.isNotEmpty
                    //     ? Icon(Icons.check, color: Colors.green)
                    //     : null,
                    enabledBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está habilitado
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está enfocado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo nombre no puede estar vacío';
                    }
                    return null;
                  
                  },
                  // Cuando se guarda el valor del campo de texto se asigna a la propiedad nombre de la instancia de la clase ConsultaMedica
                  onSaved: (value){
                    if(value!=null){
                        consultaMedica.doctor = value;
                    }
                   
                  
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  //controller: _check,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelText: 'Cita médica',
                    hintText: 'Introduzca la fecha de la consulta',
                    hintStyle: TextStyle(color: Colors.grey),// Cambia el color del texto de la pista
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold), // Cambia el color y el tamaño del texto de la etiqueta
                    filled: true, // Rellena el campo de entrada con el color de fondo
                    fillColor: Colors.white, // Cambia el color de fondo del campo de entrada
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue), // Añade un icono al principio del campo de entrada
                    // suffixIcon: _check.text.isNotEmpty
                    //     ? Icon(Icons.check, color: Colors.green)
                    //     : null,
                    suffixIcon: Icon(Icons.check, color: Colors.green), // Añade un icono al final del campo de entrada
                    enabledBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está habilitado
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está enfocado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo nombre no puede estar vacío';
                    }
                    if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(value)==false)
                    {
                      return 'El formato de la fecha no es correcto';
                    }else{
                      return null;
                    }
                  
                  },
                  // Cuando se guarda el valor del campo de texto se asigna a la propiedad nombre de la instancia de la clase ConsultaMedica
                  onSaved: (value){
                    if(value!=null){
                        consultaMedica.fecha = value;
                    }
                  
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  //controller: _check,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelText: 'Hora',
                    hintText: 'Introduzca la hora de la consulta',
                    hintStyle: TextStyle(color: Colors.grey),// Cambia el color del texto de la pista
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold), // Cambia el color y el tamaño del texto de la etiqueta
                    filled: true, // Rellena el campo de entrada con el color de fondo
                    fillColor: Colors.white, // Cambia el color de fondo del campo de entrada
                    prefixIcon: Icon(Icons.access_time, color: Colors.blue), // Añade un icono al principio del campo de entrada
                    // suffixIcon: _check.text.isNotEmpty
                    //     ? Icon(Icons.check, color: Colors.green)
                    //     : null,
                    suffixIcon: Icon(Icons.check, color: Colors.green), // Añade un icono al final del campo de entrada
                    enabledBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está habilitado
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está enfocado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),

                  validator: (value) {
                    if (value==null || value.isEmpty){
                      return 'El campo no puede estar vacio';
                  }
                  if(RegExp(r'^[0-2][0-9]:[0-5][0-9]$').hasMatch(value)==false)
                  {
                    return 'El formato de la fecha no es correcto';
                  }
                  else{
                    return null;
                  }
                  
                  },
                  // Cuando se guarda el valor del campo de texto se asigna a la propiedad nombre de la instancia de la clase ConsultaMedica
                  onSaved: (value){
                    if(value!=null){
                        consultaMedica.hora = value;
                    }
                 
                  
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  //controller: _check,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    labelText: 'Motivo',
                    hintText: 'Introduzca el motivo de la consulta',
                    hintStyle: TextStyle(color: Colors.grey),// Cambia el color del texto de la pista
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold), // Cambia el color y el tamaño del texto de la etiqueta
                    filled: true, // Rellena el campo de entrada con el color de fondo
                    fillColor: Colors.white, // Cambia el color de fondo del campo de entrada
                    prefixIcon: Icon(Icons.bookmark_added_rounded, color: Colors.blue), // Añade un icono al principio del campo de entrada
                    // suffixIcon: _check.text.isNotEmpty
                    //     ? Icon(Icons.check, color: Colors.green)
                    //     : null,
                    suffixIcon: Icon(Icons.check, color: Colors.green), // Añade un icono al final del campo de entrada
                    enabledBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está habilitado
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder( // Cambia el aspecto del borde cuando el campo de entrada está enfocado
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo nombre no puede estar vacío';
                    }else{
                      return null;
                    }
                                      
                  },
                  // Cuando se guarda el valor del campo de texto se asigna a la propiedad nombre de la instancia de la clase ConsultaMedica
                  onSaved: (value){
                    if(value!=null){
                        consultaMedica.motivo = value;
                    }
                  
                  },
                ),
                        const SizedBox(height: 50),
                    //Botón para añadir el medicamento
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0), // Ajusta el valor según tus necesidades
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton.icon(

                          onPressed: () {

                            final esSupervisor = context.read<AdminProvider>().esAdmin;
                            late int idUsuario; 

                            if(esSupervisor){

                              // Almacenamos el id del usuario seleccionado para añadir la consulta médica al usuario correcto
                               idUsuario = context.read<IdUsuarioSeleccionado>().idUsuario;
                               consultaMedica.idUsuario = idUsuario;
                            } else {
                              // Almacenamos el id del usuario logueado para añadir la consulta médica al usuario correcto
                              idUsuario = context.read<IdSupervisor>().idUsuario;
                              consultaMedica.idUsuario = idUsuario;
                            }


                            //Validación del formulario
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save(); //Guarda los datos del formulario
                              //Añadir el medicamento a la base de datos
                              BaseDeDatos.insertarBD('Consulta', consultaMedica.toMap());
                    
                              //Mostrar mensaje de confirmación despues de 1 segundo
                              Future.delayed(const Duration(seconds: 1), () {
                                //Mostrar mensaje de confirmación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Consulta añadida con éxito'),
                                  ),
                                );
                                //Volver a la pagina de inicio
                                //Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                MaterialPageRoute(builder: (context) => const ListadoConsultasMedicas() ),
                                );
                              });
                            }
                          },
                          icon: const Icon(Icons.addchart_rounded),
                          label: const Text('Agregar cita médica'),
                         
                          style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white)// Añade tu color aquí
                          ),
                        ),
                      ),
                  )

              ],
            ),
          ),
        ),

       ),
      
    );
  }
}