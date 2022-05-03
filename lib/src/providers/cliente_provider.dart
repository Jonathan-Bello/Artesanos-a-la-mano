import 'dart:convert';

import 'package:artesanos_a_la_mano/src/models/cliente_model.dart';
import 'package:http/http.dart' as http;

class ClienteProvider{
  final String _url = "187.157.132.21:82";

  Future loginCliente(String usuario, String pwd) async{
    final url = Uri.http(_url, 'Proyectos/Clientes/Login',{
      'usuario' : usuario,
      'pwd' : pwd
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    print("MENSAJEEEEEEEEEEEE");
    return decodedData;
  }

  Future <dynamic> nuevoCliente(ClienteModel cliente) async{
    final url = Uri.http(_url, 'Proyectos/Clientes/AgregarCliente',{
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

  Future<ClienteModel> getCliente(dynamic id) async{
    print("object" + id.toString());

    final url = Uri.http(_url, 'Proyectos/Clientes/GetCliente',{
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
    final url = Uri.http(_url, 'Proyectos/Clientes/ActualizarCliente',{
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