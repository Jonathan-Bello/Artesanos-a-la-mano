
import 'dart:convert';

ClienteModel clientFromJson(String str) => ClienteModel.fromJson(json.decode(str));

String clientToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
    ClienteModel({
      this.id,
      this.nombre,
      this.apellido,
      this.correo,
      this.celular,
      this.usuario,
      this.contrasea,
    });

    int id;
    String nombre;
    String apellido;
    String correo;
    int celular;
    String usuario;
    String contrasea;

    factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id         :  json["Id"],
        nombre     :  json["Nombre"].toString(),
        apellido   :  json["Apellidos"].toString(),
        correo     :  json["Correo"].toString(),
        celular    :  json["Celular"],
        usuario    :  json["Usuario"],
        contrasea  :  json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "id"          : id,
        "nombre"      : nombre,
        "apellido"    : apellido,
        "correo"      : correo,
        "celular"     : celular,
        "usuario"     : usuario,
        "Password"  : contrasea,
    };
}
