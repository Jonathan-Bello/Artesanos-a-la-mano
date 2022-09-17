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
        id: json["id"],
        usuario: json["usuario"].toString(),
        pwd: json["password"].toString(),
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        correo: json["correo"].toString(),
        celular: json["celular"].toString(),
        tienda: json["tienda"],
        calle: json["calle"].toString(),
        colonia: json["colonia"].toString(),
        cP: json["cp"],
        idMunicipio: json["idMunicipio"],
        region: json["region"],
        referencias: json["referencias"].toString(),
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
