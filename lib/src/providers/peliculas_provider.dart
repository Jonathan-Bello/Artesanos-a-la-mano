import 'dart:async';
import 'dart:convert';

import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
//import 'package:peliculas/src/models/actores_model.dart';



class PeliculasProvider{

  String _url       = 'valorarte.000webhostapp.com';
  //int _popularesPage = 0;
  bool _cargando=false;

  List<ProductoModel> _populares= new List();

  final _popularesStreamController= StreamController<List<ProductoModel>>.broadcast();

  Function(List<ProductoModel>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<ProductoModel>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

  Future<List<ProductoModel>> _procesarRespuesta(Uri url) async{
    final response= await http.get(url);

    final List<dynamic>decodedData = json.decode(response.body);
    final List<ProductoModel> productos = new List();
    //print(decodedData);

    if(decodedData==null) return [];

    decodedData.forEach( (item){
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
    //return peliculas.items;
  }


  // Future<List<ProductoModel>> getEnCines() async{
  //   final url = Uri.https(  _url , '3/movie/now_playing',
  //   {
  //     'api_key': _apikey,
  //     'language': _language,
  //   });
  //   final resp= await http.get(url);
  //   final decodeData =json.decode(resp.body);
  //   final peliculas= new Peliculas.fromJsonList(decodeData['results']);
  //   //print(peliculas.items[0].title);
  //   //print(decodeData['results']);
  //   return peliculas.items;
  // }

  Future<List<ProductoModel>> getPopulares(int id) async{
    if(_cargando){
      return[];
    }else{
      _cargando=true;
    }
    //_popularesPage++;
    //print('cargando siguiente');
    
    final url = Uri.https(_url, 'Productos/GetProductos.php', {
      'idartesano'  : id.toString(),                                                 
    });

    final resp= await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando=false;
    return resp;
  }

  // Future<List<Actor>> getCast(String peliId )async{

  //   final url= Uri.https(_url, '3/movie/$peliId/credits',{
  //     'api_key': _apikey,
  //     'language': _language,
  //   } );
  //   final resp= await http.get(url);
  //   final decodedData= json.decode(resp.body);
  //   final cast= new Cast.fromJsonList(decodedData['cast']);
  //   return cast.actores;
  // }


  // Future<List<Pelicula>> buscarPelicula(String query )async{

  //   final url= Uri.https(_url, '3/search/movie',{
  //     'api_key': _apikey,
  //     'language': _language,
  //     'query': query,
  //   } );
  //   return await _procesarRespuesta(url);

  //   //final resp= await http.get(url);
  //   //final decodedData= json.decode(resp.body);
  //   //final cast= new Cast.fromJsonList(decodedData['cast']);
  //   //return cast.actores;
  // }
}