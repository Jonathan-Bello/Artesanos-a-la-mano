import 'dart:io';

import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc{
  final _productosProvider = new ProductosProvider();

  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Function(List<ProductoModel>) get changeStreamProductos   => _productosController.sink.add;

  final _cargandoController = new BehaviorSubject<bool>();
  Stream<bool> get cargando => _cargandoController.stream;

  //Stream Aleatorio
  final _productoALikesController = new BehaviorSubject();
  Stream get productoALikesStream => _productoALikesController.stream;
  Function(Object) get changeStreamproductoALikes  => _productoALikesController.sink.add;

  void cargarProductos(int id, int idCliente) async {
    final productos = await _productosProvider.getProductos(id,idCliente);
    _productosController.sink.add( productos );
  }

  void agregarProducto( ProductoModel producto ) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String>subirFoto( File foto ) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void editarProducto( ProductoModel producto ) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto( int id ) async {
    await _productosProvider.borrarProducto(id);
  }

  void productoArtesanoLikes(int idArtesano)async{
    final producto = await _productosProvider.productoArtesanoLikes(idArtesano);
    _productoALikesController.sink.add( producto );
  }

  dispose(){
    _productosController?.close();
    _productoALikesController?.close();
    _cargandoController.close();
  }

}