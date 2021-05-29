import 'dart:convert';
import 'package:artesanos_a_la_mano/src/models/municipio_model.dart';
import 'package:http/http.dart' as http;

class MunicipiosProvider {

  String _url = "valorarte.000webhostapp.com";

  Future<List<MunicipioModel>> getMunicipiosRegion(int region) async{
    final url = Uri.https(_url, 'Municipios/GetMunicipiosPorRegion.php', {
      'region'  : region.toString(),                                                 
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    final List<MunicipioModel> muncipios = new List();
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
    final url = Uri.https( _url, 'Municipios/GetMunicipio.php', {
      'idmunicipio': idMunicipio.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    print(decodedData);
    final List<MunicipioModel> municipios = new List();
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
    final url = Uri.https(_url, 'Municipios/GetMunicipios.php', {});
    final response = await http.get(url);
    final List<dynamic>decodedData = json.decode(response.body);
    final List<MunicipioModel> municipios = new List();
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