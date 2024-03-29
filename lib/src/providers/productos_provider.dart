import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';

class ProductosProvider {
  String _url = "187.157.132.21:82";
  //Mando el producto a la base de datos
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/InsertarProducto', {
      'producto': producto.producto.toString(),
      'descripcion': producto.descripcion.toString(),
      'precio': producto.precio.toString(),
      'categoria': producto.categoria.toString(),
      'disponibilidad': producto.disponibilidad.toString(),
      'foto': producto.foto.toString(),
      'idtienda': producto.idArtesano.toString(),
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  //subo el prodcuto. Sin bloc
  Future crearProduct(String nombre, String descripcion, double precio,
      String categoria, int disponible, String urlImage, int idTienda) async {
    final url = Uri.http(_url, 'Proyectos/Productos/InsertarProducto', {
      'producto': nombre,
      'descripcion': descripcion,
      'precio': precio.toString(),
      'categoria': categoria,
      'disponibilidad': disponible.toString(),
      'foto': urlImage,
      'idtienda': idTienda.toString(),
    });
    //print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    //print(decodedData);
    return decodedData;
  }

  //Obtener productos
  Future<List<ProductoModel>> getProductos(int id, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductos', {
      'idartesano': id.toString(),
      'idcliente': idCliente.toString(),
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  //Actualizar producto
  Future<bool> editarProducto(ProductoModel producto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/ActualizarProducto', {
      'id': producto.idProducto.toString(),
      'producto': producto.producto.toString(),
      'descripcion': producto.descripcion.toString(),
      'precio': producto.precio.toString(),
      'categoria': producto.categoria.toString(),
      'disponibilidad': producto.disponibilidad.toString(),
      'foto': producto.foto.toString(),
      'idtienda': producto.idArtesano.toString(),
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  //Elimino un producto
  Future<int> borrarProducto(int idProducto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/EliminarProducto', {
      'id': idProducto.toString(),
    });
    print(url);
    final resp = await http.get(url);
    print(json.decode(resp.body));
    return 1;
  }

  //Subo la imagen al Cloudy
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'http://api.cloudinary.com/v1_1/fenixgames/image/upload?upload_preset=xhmjw41i');
    //final url = Uri.parse('http://api.cloudinary.com/v1_1/fenixgames/image/c_scale,q_50,w_481/upload?upload_preset=xhmjw41i');
    //http://api.cloudinary.com/v1_1/demo/image/upload
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    // String curl
    // =  "http://api.cloudinary.com/v1_1/fenixgames/image/destroy -X POST --data 'public_id=sample&timestamp=173719931&api_key=436464676&signature=a788d68f86a6f868af'"
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

  //Metodos acerca de productos enfocados en los clientes
  Future<List<ProductoModel>> getProductosAleatorios(
      int random, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosRandom',
        {'random': random.toString(), 'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<List<ProductoModel>> getProductosCategoria(
      int categoria, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosPorCategoria',
        {'categoria': categoria.toString(), 'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<List<ProductoModel>> getProductosRecientes(int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosDesc',
        {'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<List<ProductoModel>> getProductosMunicipio(
      int idmunicipio, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosPorMunicipio', {
      'idmunicipio': idmunicipio.toString(),
      'idcliente': idCliente.toString()
    });
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<List<ProductoModel>> getProductosRegion(
      int region, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosPorRegion',
        {'region': region.toString(), 'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<List<ProductoModel>> getProductosBusqueda(
      String busqueda, int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/BuscarProducto',
        {'producto': busqueda.toString(), 'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }
  //Metodos referentes a los likes

  Future darLike(int idcliente, int idproducto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/LikeProducto', {
      'idcliente': idcliente.toString(),
      'idproducto': idproducto.toString()
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(json.decode(response.body));
    return decodedData;
  }

  Future quitarLike(int idcliente, int idproducto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/QuitarLike', {
      'idcliente': idcliente.toString(),
      'idproducto': idproducto.toString()
    });
    print(url);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    print(json.decode(response.body));
    return decodedData;
  }

  Future<int> getLikesdeProducto(int idproducto) async {
    final url = Uri.http(_url, 'Proyectos/Productos/ProductosLike',
        {'idproducto': idproducto.toString()});
    print(url);
    final response = await http.get(url);
    final int decodedData = json.decode(response.body);
    print(decodedData);

    return decodedData;

    // if (decodedData.isEmpty) return 0;

    // final List<dynamic> like = [];
    // //print(decodedData);
    // // return 1;
    // decodedData.forEach((item) {
    //   //print(item);
    //   final prodTemp = item['NoLikes'];
    //   //print(prodTemp.toString());
    //   like.add(prodTemp);
    // });
    // print(like[0]);
    // return int.parse(like[0]);
  }

  Future<List<ProductoModel>> getProductosMasLikes(int idCliente) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductosMasLikes',
        {'idcliente': idCliente.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData == null) return [];

    decodedData.forEach((item) {
      final prodTemp = ProductoModel.fromJson(item);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future productoArtesanoLikes(int idArtesano) async {
    final url = Uri.http(_url, 'Proyectos/Productos/GetProductoMasLikeArtesano',
        {'idartesano': idArtesano.toString()});
    print(url);
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    //final List<ProductoModel> productos = [];
    //print(decodedData);

    if (decodedData.isEmpty) return 2;

    print(decodedData[0]);
    return decodedData[0];
    // decodedData.forEach( (item){
    //   final prodTemp = ProductoModel.fromJson(item);
    //   productos.add(prodTemp);
    // });
    // //print(productos);
    // return productos;
  }
}
