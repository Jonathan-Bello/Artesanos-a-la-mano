import 'dart:convert';

import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:http/http.dart' as http;

class ClienteProvider{
  final String _url = "valorarte.000webhostapp.com";

  Future loginCliente(String usuario, String pwd) async{
    final url = Uri.https(_url, 'Clientes/Login.php',{
      'usuario' : usuario,
      'password' : pwd
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }

  Future <dynamic> nuevoCliente(ClienteModel cliente) async{
    final url = Uri.https(_url, 'Clientes/AgregarCliente.php',{
      'nombre'    : cliente.nombre.toString(),
      'apellidos' : cliente.apellido.toString(),
      'correo'    : cliente.correo.toString(),
      'celular'   : cliente.celular.toString(),
      'usuario'   : cliente.usuario.toString(),
      'pwd'       : cliente.contrasea.toString()
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }

  Future<ClienteModel> getCliente(int id) async{
    final url = Uri.https(_url, 'Clientes/GetCliente.php',{
      'id' : id.toString(),
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cliente= ClienteModel.fromJson(decodedData);
    print(decodedData);
    return cliente;
  }

  Future actualizarCliente(ClienteModel cliente) async{
    final url = Uri.https(_url, 'Clientes/ActualizarCliente.php',{
      'id'        : cliente.id.toString(),
      'nombre'    : cliente.nombre.toString(),
      'apellidos' : cliente.apellido.toString(),
      'correo'    : cliente.correo.toString(),
      'celular'   : cliente.celular.toString(),
      'usuario'   : cliente.usuario.toString(),
      'pwd'       : cliente.contrasea.toString()
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return decodedData;
  }
}