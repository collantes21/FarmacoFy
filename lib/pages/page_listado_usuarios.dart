import 'package:farmacofy/BBDD/bbdd.dart';
import 'package:farmacofy/inicioSesion/pantallaLogin.dart';
import 'package:farmacofy/pages/page_listado_tratamientos.dart';
import 'package:farmacofy/pages/page_nuevo_usuario.dart';
import 'package:farmacofy/pages/page_tratamiento.dart';
import 'package:farmacofy/pantallaInicial.dart';
import 'package:farmacofy/presentacion/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';






class ListadoUsuarios extends StatefulWidget {
  const ListadoUsuarios({super.key});

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class IdUsuarioSeleccionado with ChangeNotifier {
  int _idUsuario = 0;

  int get idUsuario => _idUsuario;

  void setIdUsuario(int id) {
    _idUsuario = id;
    notifyListeners();
  }
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  @override
  Widget build(BuildContext context) {

    // Obtener el id del usuario del proveedor
    final usuarioProvider = context.read<IdSupervisor>();
    final int idAdministrador = usuarioProvider.idUsuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        backgroundColor: const Color(0xFF02A724),
        flexibleSpace: Container(
          //Sirve para definir el color de la barra de estado
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
          IconButton(
            onPressed: () {
              // Acción para el botón de configuración
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      drawer: MenuDrawer(), // Agrega el Drawer aquí

      body: Stack(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: BaseDeDatos.consultarUsuariosPorIdAdministrador(
                idAdministrador),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Mientras espera la respuesta de la BD muestra un indicador de carga
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                  
                          // Guardar el ID del usuario en el Provider
                          final usuarioId = snapshot.data![index]['id'] as int;
                          Provider.of<IdUsuarioSeleccionado>(context, listen: false).setIdUsuario(usuarioId);

                          final esAdmin=BaseDeDatos.obtenerRolAdministrador(usuarioId);

                        

                          ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'ID Usuario: $usuarioId'),
                      ),
                    );

                          // Navegar a la pantalla de detalle del usuario

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListadoTratamientos()),
                          );
                        },
                        //Separacion entre las tarjetas
                        // margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.userMd,
                            color: Colors.blue,
                            size: 40.0,
                          ),
                          title: Text(
                            snapshot.data![index]['nombre'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data![index]['usuario'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 12, 42, 173),
                                    fontSize: 15.0),
                              ),
                              Text(
                                'Hora cita: ' +
                                    snapshot.data![index]['contrasena'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 4, 167, 12),
                                    fontSize: 17.0),
                              ), // Añade la hora aquí
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AnadirUsuario()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF02A724),
      ),
    );
  }
}


















// class ListadoUsuarios extends StatefulWidget {
//   const ListadoUsuarios({super.key});

//   @override
//   State<ListadoUsuarios> createState() => _ListadoUsuariosState();
// }

// class _ListadoUsuariosState extends State<ListadoUsuarios> {
//   @override
//   Widget build(BuildContext context) {
//     // Obtener el id del usuario del proveedor
//     final usuarioProvider = context.read<IdSupervisor>();
//     final int idAdministrador = usuarioProvider.idUsuario;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Usuarios'),
//         backgroundColor: const Color(0xFF02A724),
//         flexibleSpace: Container(
//           //Sirve para definir el color de la barra de estado
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF02A724),
//                 Color.fromARGB(255, 18, 240, 63),
//                 Color.fromARGB(255, 11, 134, 34),
//               ],
//             ),
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Acción para el botón de configuración
//             },
//             icon: const Icon(Icons.share),
//           ),
//         ],
//       ),
//       drawer: MenuDrawer(), // Agrega el Drawer aquí

//       body: Stack(
//         children: [
//           FutureBuilder<List<Map<String, dynamic>>>(
//             future: BaseDeDatos.consultarUsuariosPorIdAdministrador(
//                 idAdministrador),
//             builder: (BuildContext context,
//                 AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 // Mientras espera la respuesta de la BD muestra un indicador de carga
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ListadoUsuarios()),
//                           );
//                         },
//                         //Separacion entre las tarjetas
//                         // margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//                         child: ListTile(
//                           leading: Icon(
//                             FontAwesomeIcons.userMd,
//                             color: Colors.blue,
//                             size: 40.0,
//                           ),
//                           title: Text(
//                             snapshot.data![index]['nombre'],
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 snapshot.data![index]['usuario'],
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 12, 42, 173),
//                                     fontSize: 15.0),
//                               ),
//                               Text(
//                                 'Hora cita: ' +
//                                     snapshot.data![index]['contrasena'],
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 4, 167, 12),
//                                     fontSize: 17.0),
//                               ), // Añade la hora aquí
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushReplacement(
//             context,
//             //Cambiar a pantalla de Formulario medicamento
//             // MaterialPageRoute(builder: (context) => const Tratamientos1()),
//             MaterialPageRoute(builder: (context) => const AnadirUsuario()),
//           );
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: const Color(0xFF02A724),
//       ),
//     );
//   }
// }
