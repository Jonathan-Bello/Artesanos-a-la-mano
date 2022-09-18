import 'dart:convert';
import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:http/http.dart' as http;
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';

class ArtesanoProvider {
  String _url = "187.157.132.21:82";
  //Obtener Artesano
  Future<ArtesanosModel> obtenerArtesano(int idArtesano) async {
    final url = Uri.http(_url, 'Proyectos/Artesanos/GetArtesano', {
      'id': idArtesano.toString(),
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final ArtesanosModel artesanosModel = ArtesanosModel.fromJson(decodedData);
    print(decodedData);
    return artesanosModel;
  }

  //Editar Prodcuto
  Future<bool> editarArtesano(ArtesanosModel artesano) async {
    final url = Uri.http(_url, 'Proyectos/Artesanos/ActualizarArtesano', {
      'id': artesano.id.toString(),
      'usuario': artesano.usuario.toString(),
      'pwd': artesano.pwd.toString(),
      'nombre': artesano.nombre.toString(),
      'apellidos': artesano.apellidos.toString(),
      'correo': artesano.correo.toString(),
      'celular': artesano.celular.toString(),
      'tienda': artesano.tienda.toString(),
      'calle': artesano.calle.toString(),
      'colonia': artesano.colonia.toString(),
      'cp': artesano.cP.toString(),
      'idmunicipio': artesano.idMunicipio.toString(),
      //'region' : artesano.region.toString(),
      'referencias': artesano.referencias.toString()
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  //Artesanos por Region
  Future<List<ArtesanosModel>> getArtesanoRegion(int region) async {
    final url = Uri.http(_url, 'Proyectos/Artesanos/GetArtesanosPorRegion', {
      'region': region.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ArtesanosModel> artesanos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ArtesanosModel.fromJson(item);
      artesanos.add(prodTemp);
    });
    //print(productos);
    return artesanos;
  }

  //Artesanos por municipio
  Future<List<ArtesanosModel>> getArtesanoMunicipio(int municipio) async {
    final url = Uri.http(_url, 'Proyectos/Artesanos/GetArtesanosPorMunicipio', {
      'idmunicipio': municipio.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ArtesanosModel> artesanos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ArtesanosModel.fromJson(item);
      artesanos.add(prodTemp);
    });
    //print(productos);
    return artesanos;
  }

  Future<MunicipioModel> consultarMunicipio(int idMunicipio) async {
    final url = Uri.http(_url, 'Proyectos/Municipios/GetMunicipio', {
      'idmunicipio': idMunicipio.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    print(decodedData);
    final List<MunicipioModel> municipios = [];
    //print(decodedData);

    decodedData.forEach((item) {
      final prodTemp = MunicipioModel.fromJson(item);
      municipios.add(prodTemp);
    });
    print(municipios[0].nombre);
    return municipios[0];
  }

  //Obtener municipios
  Future<List<MunicipioModel>> todosLosMunicipios() async {
    final url = Uri.http(_url, 'Proyectos/Municipios/GetMunicipios', {});
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<MunicipioModel> municipios = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = MunicipioModel.fromJson(item);
      municipios.add(prodTemp);
    });
    //print(municipios);
    return municipios;
  }
}
