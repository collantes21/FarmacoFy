
import 'package:farmacofy/BBDD/bbdd.dart';
import 'package:farmacofy/BBDD/bbdd_medicamento_old.dart';

class ConsultaMedica {
  int? _id;
  late String _especialista;
  late String _doctor;
  late String _fecha;
  late String _hora;
  late String _motivo;
  late int _idUsuario;
  

  ConsultaMedica(){
    _especialista = "";
    _doctor = "";
    _fecha = "";
    _hora = "";
    _motivo = "";
    _idUsuario = 0;
  }

  ConsultaMedica.withData(String especialista, String doctor, String fecha, String hora, String motivo, int idUsuario){
    _especialista = especialista;
    _doctor = doctor;
    _fecha = fecha;
    _hora = hora;
    _motivo = motivo;
    _idUsuario = idUsuario;
  }

  ConsultaMedica.withId(int id, String especialista, String doctor, String fecha, String hora, String motivo,  int idUsuario){
    _id = id;
    _especialista = especialista;
    _doctor = doctor;
    _fecha = fecha;
    _hora = hora;
    _motivo = motivo;
    _idUsuario = idUsuario;
  }

  // Getters y setters

  int? get id => _id;
  String get especialista => _especialista;
  String get doctor => _doctor;
  String get fecha => _fecha;
  String get hora => _hora;
  String get motivo => _motivo;
  int get idUsuario => _idUsuario;

  set especialista(String especialista) {
    _especialista = especialista;
  }

  set doctor(String doctor) {
    _doctor = doctor;
  }

  set fecha(String fecha) {
    _fecha = fecha;
  }

  set hora(String hora) {
    _hora = hora;
  }

  set motivo(String motivo) {
    _motivo = motivo;
  }

  set idUsuario(int idUsuario) {
    _idUsuario = idUsuario;
  }

  // Convertir un objeto de tipo ConsultaMedica a un objeto de tipo Map
  // Esto es útil cuando necesitas guardar un objeto ConsultaMedica en una base de datos o enviarlo a una API

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(id != null && id != 0){ // Si el id es diferente de null y 0, significa que el objeto ya existe en la base de datos y solo hay que actualizarlo
      map['id'] = _id;
    }
    map['especialista'] = _especialista;
    map['doctor'] = _doctor;
    map['fecha'] = _fecha;
    map['hora'] = _hora;
    map['motivo'] = _motivo;
    map['idUsuario'] = _idUsuario;
    return map;
  }

  // Convertir un objeto tipo Map a un objeto de tipo ConsultaMedica
  // Esto es útil cuando recibes un objeto Map de una API y necesitas convertirlo a un objeto ConsultaMedica

  ConsultaMedica.fromMapObject(dynamic map){ // Constructor que recibe un objeto Map y lo rellena con los datos de las columnas de la tabla
    _id = map['id'];
    _especialista = map['especialista'];
    _doctor = map['doctor'];
    _fecha = map['fecha'];
    _hora = map['hora'];
    _motivo = map['motivo'];
    _idUsuario = map['idUsuario'];
  }

  Future<List<ConsultaMedica>> obtenerProximasConsultas(bool modoLocal) async {
    List<ConsultaMedica> proximasConsultas = [];

    if(modoLocal) {
      // Obtener las consultas de la base de datos local
      BaseDeDatos bd = BaseDeDatos();
      List<Map<String, dynamic>> consultas = await BaseDeDatos.consultarBD('Consulta');
      for(int i = 0; i < consultas.length; i++) {
        proximasConsultas.add(ConsultaMedica.fromMapObject(consultas[i]));
      }

    } else {
      /**
       * ! IMPORTANTE!
       * * Obtener las consultas de la base de datos remota API
       * ? Aquí se haría la petición a la API para obtener las consultas
       * ? y se rellenaría el array de proximasConsultas con los datos obtenidos
       * * A continuación se muestra un posible ejemplo de cómo se haría la petición
       */

      // Ejemplo:
      // var response = await http.get('https://api.com/consultas');
      // if(response.statusCode == 200) {
      //   var consultas = json.decode(response.body);
      //   for(int i = 0; i < consultas.length; i++) {
      //     proximasConsultas.add(ConsultaMedica.fromMapObject(consultas[i]));
      //   }
      // }
      // return proximasConsultas;
      // En este caso, como no tenemos una API real, simplemente devolvemos un array vacío
      // para simular que no hay consultas
      return proximasConsultas; 

    }

    return proximasConsultas;
  }


}