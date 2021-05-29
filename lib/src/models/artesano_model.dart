// To parse this JSON data, do
//
//     final artesanos = artesanosFromJson(jsonString);
import 'dart:convert';

ArtesanosModel artesanosFromJson(String str) => ArtesanosModel.fromJson(json.decode(str));

String artesanosToJson(ArtesanosModel data) => json.encode(data.toJson());

class ArtesanosModel { 
    int id;
    String usuario;
    String pwd;
    String nombre;
    String apellidos;
    String correo;
    String celular;
    String tienda;
    String calle;
    String colonia;
    int cP;
    int idMunicipio;
    int region;
    String referencias;

    ArtesanosModel({
        this.id,
        this.usuario='',
        this.pwd='',
        this.nombre='',
        this.apellidos='',
        this.correo='',
        this.celular='',
        this.tienda='',
        this.calle='',
        this.colonia='',
        this.cP=0,
        this.idMunicipio=1,
        this.region=0,
        this.referencias='',
    });

    factory ArtesanosModel.fromJson(Map<String, dynamic> json) => ArtesanosModel(
        id: json["Id"],
        usuario: json["Usuario"].toString(),
        pwd: json["Password"].toString(),
        nombre: json["Nombre"],
        apellidos: json["Apellidos"],
        correo: json["Correo"].toString(),
        celular: json["Celular"].toString(),
        tienda: json["Tienda"],
        calle: json["Calle"].toString(),
        colonia: json["Colonia"].toString(),
        cP: json["CP"],
        idMunicipio: json["IdMunicipio"],
        region: json["Region"],
        referencias: json["Referencias"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "pwd": pwd,
        "nombre": nombre,
        "apellidos": apellidos,
        "correo": correo,
        "celular": celular,
        "tienda": tienda,
        "calle": calle,
        "colonia": colonia,
        "cP": cP,
        "idMunicipio": idMunicipio,
        "region": region,
        "referencias": referencias,
    };
}
