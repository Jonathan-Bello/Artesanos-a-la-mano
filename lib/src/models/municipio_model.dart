import 'dart:convert';

MunicipioModel municipioFromJson(String str) => MunicipioModel.fromJson(json.decode(str));

String municipioToJson(MunicipioModel data) => json.encode(data.toJson());

class MunicipioModel {
    MunicipioModel({
        this.idMunicipio,
        this.nombre,
        this.region,
    });

    int idMunicipio;
    String nombre;
    int region;

    factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        idMunicipio: json["id"],
        nombre: json["nombre"],
        region: json["region"],
    );

    Map<String, dynamic> toJson() => {
        "idMunicipio": idMunicipio,
        "Nombre": nombre,
        "Region": region,
    };
}
