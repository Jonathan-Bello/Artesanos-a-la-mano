import 'dart:convert';
import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:http/http.dart' as http;

class MunicipiosProvider {

  String _url = "187.157.132.21:82";

  Future<List<MunicipioModel>> getMunicipiosRegion(int region) async{
    final url = Uri.http(_url, 'Proyectos/Municipios/GetMunicipiosRegion', {
      'region'  : region.toString(),                                                 
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    final List<MunicipioModel> muncipios = [];
    //print(decodedData);

    if(decodedData==null) return [];

    decodedData.forEach( (item){
      final prodTemp = MunicipioModel.fromJson(item);
      muncipios.add(prodTemp);
    });
    //print(productos);
    return muncipios;
  }

  Future<MunicipioModel> consultarMunicipio(int idMunicipio) async {
    final url = Uri.http( _url, 'Proyectos/Municipios/GetMunicipio', {
      'idmunicipio': idMunicipio.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    print(decodedData);
    final List<MunicipioModel> municipios = [];
    //print(decodedData);

    decodedData.forEach( (item){
      final prodTemp = MunicipioModel.fromJson(item);
      municipios.add(prodTemp);
    });
    print(municipios[0].nombre);
    return municipios[0];
  }

  //Obtener municipios
  Future<List<MunicipioModel>> todosLosMunicipios() async{
    final url = Uri.http(_url, 'Proyectos/Municipios/GetMunicipios', {});
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    final List<MunicipioModel> municipios = [];
    //print(decodedData);

    if(decodedData==null) return [];

    decodedData.forEach( (item){
      final prodTemp = MunicipioModel.fromJson(item);
      municipios.add(prodTemp);
    });
    //print(municipios);
    return municipios;
  }
}