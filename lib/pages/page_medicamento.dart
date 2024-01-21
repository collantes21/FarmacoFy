
import 'package:farmacofy/BBDD/bbdd_medicamento.dart';
import 'package:farmacofy/models/medicamento.dart';
import 'package:farmacofy/pantallaInicial.dart';
import 'package:flutter/material.dart';

class PaginaMedicamento extends StatefulWidget {
  const PaginaMedicamento({super.key});

  @override
  State<PaginaMedicamento> createState() => _PaginaMedicamentoState();
}

class _PaginaMedicamentoState extends State<PaginaMedicamento> {
    
    final _formKey = GlobalKey<FormState>();
    Medicamento medicamento = Medicamento();
    BDHelper bdHelper = BDHelper();

  @override
  Widget build(BuildContext context) {

    final tema = Theme.of(context);
    

    return  GestureDetector( //Para quitar el foco de los campos de texto al pulsar fuera de ellos
      onTap: () {
        //Quitar el foco de los campos de texto al pulsar fuera de ellos
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: const Color(0xFF02A724),
          title: Text('Añadir medicamento',
         
            style: TextStyle(
            //Color del texto
            color: tema.colorScheme.onPrimary,

        ),
        
        
       ),
     
       flexibleSpace: Container(
        //Color de la barra
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                
                tema.colorScheme.primary,
                tema.colorScheme.secondary,
              ],
             ),
           ),
          ),
          iconTheme: IconThemeData(
            //Color de los iconos 
            color: tema.colorScheme.onPrimary,
          ),
          ),

          //Cuerpo de la página con un formulario para añadir un medicamento
          body: Form(
            key: _formKey, //Clave del formulario para validar los campos
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Datos del medicamento',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: tema.colorScheme.secondary,
                      ),
                    ),
                  ),
                  //Campo para introducir el nombre del medicamento
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre del medicamento',
                        hintText: 'Introduce el nombre del medicamento',
                        icon: Icon(Icons.medication_rounded),
                      ),
                      //Validación del campo
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce el nombre del medicamento';
                        }
                        return null;
                      },
                      //Asignación del valor del campo al atributo nombre del objeto medicamento
                      onSaved: (value) {
                        medicamento.nombre = value!;
                      },
                    ),
                  ),
                  //Campo para introducir la descripción del medicamento
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descripción del medicamento',
                        hintText: 'Introduce la descripción del medicamento',
                     
                        icon: Icon(Icons.description_rounded),
                      ),
                      maxLines: 3,
                      //Validación del campo
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce la descripción del medicamento';
                        }
                        return null;
                      },
                      //Asignación del valor del campo al atributo descripción del objeto medicamento
                      onSaved: (value) {
                        medicamento.descripcion = value!;
                      },
                    ),
                  ),
                  // Campo para indicar la fecha de caducidad del medicamento
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de caducidad',
                        hintText: 'Introduce la fecha de caducidad del medicamento',
                        icon: Icon(Icons.calendar_today_rounded),
                      ),
                      //Validación del campo
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce la fecha de caducidad del medicamento';
                        }
                        if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(value)==false)
                        {
                          return 'El formato de la fecha es incorrecto';
                        }
                        List<String> datoFecha = value.split('/');
                        int dia = int.tryParse(datoFecha[0])!;
                        int mes = int.tryParse(datoFecha[1])!;
                        int anio = int.tryParse(datoFecha[2])!;

                        try{
                          DateTime fechaCaducidad = new DateTime(anio, mes, dia);
                         // medicamento.fechaCaducidad = fechaCaducidad; //Asignación del valor del campo al atributo fechaCaducidad del objeto medicamento
                        }
                        catch(e){
                          return 'La fecha introducida no es válida';
                        }
                        return null;
                      },
                      //Asignación del valor del campo al atributo fechaCaducidad del objeto medicamento
                      onSaved: (value){
                        if(value != null)
                        {
                          medicamento.diaCaducidad = value;
                          
                        }
                      },
                    ),
                    ),
                    //Campo del tipo de envase del medicamento
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                labelText: 'Tipo de envase',
                                hintText: 'Introduce el tipo de envase del medicamento',
                                icon: Icon(Icons.medication_liquid),
                                                             

                              ),
                              items: const [
                                DropdownMenuItem(
                                  
                                  value: 'Caja',
                                  child: Text('Caja'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Bote',
                                  child: Text('Bote'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Tubo',
                                  child: Text('Tubo'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Sobre',
                                  child: Text('Sobre'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Ampolla',
                                  child: Text('Ampolla'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Jeringa',
                                  child: Text('Jeringa'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Spray',
                                  child: Text('Spray'),
                                ),
                                DropdownMenuItem(
                                  
                                  value: 'Otro',
                                  child: Text('Otro'),
                                ),
                                
                              
                              ], 
                              onChanged: (String? value) { 
                                medicamento.tipoEnvase = value!; //Asignación del valor del campo al atributo tipoEnvase del objeto medicamento
                               },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, introduce el tipo de envase del medicamento';
                                }
                                return null;
                              },
                              onSaved: (value){
                                medicamento.tipoEnvase = value!;
                              }
                                                         
                            
                            ),
                          ),
                        ],
                      )
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: tema.colorScheme.secondary,
                        thickness: 2,
                      ),
                      //Datos de campos para prescripción médica
                      ListTile(
                        title: Text(
                          'Prescripción médica',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: tema.colorScheme.secondary,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Dosis',
                            hintText: 'Introduce la dosis del medicamento en cada toma',
                            icon: Icon(Icons.medication_liquid_sharp),
                          ),
                          keyboardType: TextInputType.number,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la dosis del medicamento';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo dosis del objeto medicamento
                          onSaved: (value) {
                            medicamento.dosis = int.parse(value!);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Frecuencia',
                                  hintText: 'Introduce la frecuencia del medicamento',
                                  icon: Icon(Icons.medication_liquid),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Cada 8 horas',
                                    child: Text('Cada 8 horas'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Cada 12 horas',
                                    child: Text('Cada 12 horas'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Cada 24 horas',
                                    child: Text('Cada 24 horas'),
                                  ),
                           
                          ],
                          onChanged: (String? value) {
                            medicamento.frecuencia = value!; //Asignación del valor del campo al atributo frecuencia del objeto medicamento
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la frecuencia del medicamento';
                            }
                            return null;
                          },
                          onSaved: (value){
                            medicamento.frecuencia = value!;
                           },
                          ),
                         ),
                        ],
                       ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Via de administración',
                                  hintText: 'Introduce la via de administración del medicamento',
                                  icon: Icon(Icons.local_hospital_rounded),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Oral',
                                    child: Text('Oral'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Intravenosa',
                                    child: Text('Intravenosa'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Intramuscular',
                                    child: Text('Intramuscular'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Subcutánea',
                                    child: Text('Subcutánea'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Rectal',
                                    child: Text('Rectal'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Otro',
                                    child: Text('Otro'),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  medicamento.viaAdministracion = value!; //Asignación del valor del campo al atributo viaAdministracion del objeto medicamento
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, introduce la via de administración del medicamento';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  medicamento.viaAdministracion = value!;
                                }
                              ),
                              )
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Duración',
                            hintText: 'Introduce la duración del medicamento',
                            icon: Icon(Icons.timelapse),
                          ),
                          keyboardType: TextInputType.text,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la duración del medicamento';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo duracion del objeto medicamento
                          onSaved: (value) {
                            medicamento.duracion = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: tema.colorScheme.secondary,
                        thickness: 2,
                      ),
                      //Datos de campos para el control de stock
                      ListTile(
                        title: Text(
                          'Control de stock',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: tema.colorScheme.secondary,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cantidad del envase',
                            hintText: 'Introduce la cantidad del envase',
                            icon: Icon(Icons.local_drink),
                          ),
                          keyboardType: TextInputType.number,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la cantidad del envase';
                            }
                           
                            //Controlar que sea un número entero positivo
                            if(RegExp(r'^[0-9]+$').hasMatch(value)==false)
                            {
                              return 'La cantidad debe ser un número';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo cantidadEnvase del objeto medicamento
                          onSaved: (value) {
                            medicamento.cantidadEnvase = int.parse(value!); 
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cantidad mínima',
                            hintText: 'Introduce la cantidad mínima del medicamento',
                            icon: Icon(Icons.shopping_cart_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la cantidad mínima';
                            }
                            //Controlar que sea un número entero positivo
                            if(RegExp(r'^[0-9]+$').hasMatch(value)==false)
                            {
                              return 'La cantidad debe ser un número';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo cantidadMinima del objeto medicamento
                          onSaved: (value) {
                            medicamento.cantidadMinima = int.parse(value!);
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cantidad actual',
                            hintText: 'Introduce la cantidad actual del medicamento',
                            icon: Icon(Icons.battery_5_bar),
                          ),
                          keyboardType: TextInputType.number,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la cantidad actual';
                            }
                            //Controlar que sea un número entero positivo
                            if(RegExp(r'^[0-9]+$').hasMatch(value)==false)
                            {
                              return 'La cantidad debe ser un número';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo cantidadActual del objeto medicamento
                          onSaved: (value) {
                            medicamento.cantidadActual = int.parse(value!);
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: tema.colorScheme.secondary,
                        thickness: 2,
                      ),
                      const SizedBox(height: 10),
                      //Datos de campos para el control de recordatorio
                      ListTile(
                        title: Text(
                          'Recordatorio',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: tema.colorScheme.secondary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Recordatorio',
                                  hintText: 'Introduce si el medicamento tiene recordatorio',
                                  icon: Icon(Icons.alarm),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: true,
                                    child: Text('Sí'),
                                  ),
                                  DropdownMenuItem(
                                    value: false,
                                    child: Text('No'),
                                  ),
                                ],
                                onChanged: (bool? value) {
                                  medicamento.recordatorio = value!; //Asignación del valor del campo al atributo recordatorio del objeto medicamento
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor, seleccione si el medicamento tiene recordatorio';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  medicamento.recordatorio = value!;
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de inicio',
                            hintText: 'Introduce la fecha de inicio del medicamento',
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          keyboardType: TextInputType.datetime,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la fecha de inicio';
                            }
                            if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(value)==false)
                            {
                              return 'El formato de la fecha es incorrecto';
                            }
                            List<String> datoFecha = value.split('/');
                              int dia = int.tryParse(datoFecha[0])!;
                              int mes = int.tryParse(datoFecha[1])!;
                              int anio = int.tryParse(datoFecha[2])!;

                            try{
                              DateTime fechaInicio = DateTime(anio, mes, dia);
                              //medicamento.fechaInicio = fechaInicio; //Asignación del valor del campo al atributo fechaInicio del objeto medicamento
                            }
                            catch(e){
                              return 'El formato fecha introducida no es válida';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo fechaInicio del objeto medicamento
                          onSaved: (value){
                            if(value != null)
                            {
                              medicamento.diaInicio = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de fin',
                            hintText: 'Introduce la fecha de fin del medicamento',
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          keyboardType: TextInputType.datetime,
                          //Validación del campo
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce la fecha de fin';
                            }
                            if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(value)==false)
                            {
                              return 'El formato de la fecha es incorrecto';
                            }
                            List<String> datoFecha = value.split('/');
                              int dia = int.tryParse(datoFecha[0])!;
                              int mes = int.tryParse(datoFecha[1])!;
                              int anio = int.tryParse(datoFecha[2])!;

                            try{
                              DateTime fechaFin = DateTime(anio, mes, dia);
                              //medicamento.fechaFin = fechaFin; //Asignación del valor del campo al atributo fechaFin del objeto medicamento
                            }
                            catch(e){
                              return 'El formato fecha introducida no es válida';
                            }
                            return null;
                          },
                          //Asignación del valor del campo al atributo fechaFin del objeto medicamento
                          onSaved: (value){
                            if(value != null)
                            {
                              medicamento.diaFin = value;
                            }
                          },
                        ),
                      ),
                       
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CheckboxListTile(
                          
                          title: Text(
                            "Activar medicamento",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: tema.colorScheme.secondary,
                             
                            ),
                          ),
                          value: medicamento.activado, //Asignación del valor del campo al atributo activado del objeto medicamento
                          onChanged: (bool? value) {
                            setState(() {
                              medicamento.activado = value!;
                            });
                          },
                          secondary: const Icon(Icons.notification_add),
                        ),
                        
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: tema.colorScheme.secondary,
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                      //Datos de campos para el control de imágenes
                      ListTile(
                        title: Text(
                          'Imágenes',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: tema.colorScheme.secondary,
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logo Medicamento',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: tema.colorScheme.secondary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_a_photo_rounded),
                            
                          ),
                          Text(
                            'Imagen Envase',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: tema.colorScheme.secondary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add_a_photo_outlined),
                            
                          ),
                        
                        ],
                      ),
                      
                    ),
                    //Campo para introducir notas
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Notas',
                          hintText: 'Introduce notas sobre el medicamento',
                          icon: Icon(Icons.note_add_rounded),
                        ),
                      
                      ),

                    ),

                    const SizedBox(height: 15),
                    Divider(
                      color: tema.colorScheme.secondary,
                      thickness: 2,
                    ), 
                    const SizedBox(height: 50),
                    //Botón para añadir el medicamento
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0), // Ajusta el valor según tus necesidades
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            //Validación del formulario
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save(); //Guarda los datos del formulario
                              //Añadir el medicamento a la base de datos
                              bdHelper.insertarBD('Medicamento', medicamento.toMap());
                    
                              //Mostrar mensaje de confirmación despues de 1 segundo
                              Future.delayed(const Duration(seconds: 1), () {
                                //Mostrar mensaje de confirmación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Medicamento añadido correctamente'),
                                  ),
                                );
                                //Volver a la pagina de inicio
                                //Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                MaterialPageRoute(builder: (context) => const PantallaInicial() ),
                                );
                              });
                            }
                          },
                          child: Text('Añadir medicamento'),
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