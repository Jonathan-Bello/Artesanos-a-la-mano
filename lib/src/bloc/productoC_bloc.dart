import 'package:rxdart/rxdart.dart';

import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';


class ProductosClienteBloc{
  final _productosProvider = new ProductosProvider();

  //Stream Aleatorio
  final _productosAleatoriosController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosAleatorios => _productosAleatoriosController.stream;
  Function(List<ProductoModel>) get changeStreamAleatorios   => _productosAleatoriosController.sink.add;

  //Stream Categoria
  final _productosCategoriaController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosCategoria => _productosCategoriaController.stream;
  Function(List<ProductoModel>) get changeStreamCategoria   => _productosCategoriaController.sink.add;

  final _cargandoController = new BehaviorSubject<bool>();
  Stream<bool> get cargando => _cargandoController.stream;

  //Stream Recientes
  final _productosRecientesController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosRecientes => _productosRecientesController.stream;
  Function(List<ProductoModel>) get changeStreamRecientes   => _productosRecientesController.sink.add;

  //Stream Municipio
  final _productosMunicipioController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosMunicipio => _productosMunicipioController.stream;
  Function(List<ProductoModel>) get changeStreamMunicipio   => _productosMunicipioController.sink.add;

  //Stream Region
  final _productosRegionController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosRegion => _productosRegionController.stream;
  Function(List<ProductoModel>) get changeStreamRegion   => _productosRegionController.sink.add;

  //Stream NumeroLike
  final _likesController = new BehaviorSubject<int>();
  Stream<int> get likes => _likesController.stream;
  Function(int) get changeStreamlikes   => _likesController.sink.add;

    //Stream Region
  final _productosPopularesController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosPopulares => _productosPopularesController.stream;
  Function(List<ProductoModel>) get changeStreamPopulares   => _productosPopularesController.sink.add;

  Future<bool> cargarProductosAleatorios(int random, int idCliente) async {
    final productos = await _productosProvider.getProductosAleatorios(random, idCliente);
    _productosAleatoriosController.sink.add( productos );
    return true;
  }

  void cargarProductosCategoria(int  categoria,int idCliente) async {
    final productos = await _productosProvider.getProductosCategoria(categoria,idCliente);
    _productosCategoriaController.sink.add( productos );
  }

  void cargarProductosRecientes(int idCliente) async {
    final productos = await _productosProvider.getProductosRecientes(idCliente);
    _productosRecientesController.sink.add( productos );
  }

  void cargarProductosMunicipio(int municipio,int idCliente) async {
    final productos = await _productosProvider.getProductosMunicipio(municipio,idCliente);
    _productosMunicipioController.sink.add( productos );
  }

  void cargarProductosRegion(int region,int idCliente) async {
    final productos = await _productosProvider.getProductosRegion(region,idCliente);
    _productosRegionController.sink.add( productos );
  }

  void darLike( int idCliente, int idProducto ) async {
    _cargandoController.sink.add(true);
    await _productosProvider.darLike(idCliente, idProducto);
    _cargandoController.sink.add(false);
  }

  void quitarLike( int idCliente, int idProducto ) async {
    _cargandoController.sink.add(true);
    await _productosProvider.quitarLike(idCliente, idProducto);
    _cargandoController.sink.add(false);
  }

  Future<int> obtenerLike( int idProducto ) async {
    _cargandoController.sink.add(true);
    int likes = await _productosProvider.getLikesdeProducto(idProducto);
    _cargandoController.sink.add(false);
    _likesController.sink.add( likes );
    return likes;
  }

  void cargarProductosPopulares(int idCliente) async {
    final productos = await _productosProvider.getProductosMasLikes(idCliente);
    _productosPopularesController.sink.add( productos );
  }

  dispose(){
    _productosAleatoriosController?.close();
    _productosCategoriaController?.close();
    _productosRecientesController?.close();
    _productosMunicipioController?.close();
    _productosRegionController?.close();
    _likesController?.close();
    _productosPopularesController?.close();
    _cargandoController.close();
  }
}