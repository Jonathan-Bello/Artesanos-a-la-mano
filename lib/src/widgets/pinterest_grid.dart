import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CrearPinterestGrid extends StatelessWidget {
  final productosProvider = new ProductosProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.getProductosAleatorios(20, prefs.idCliente),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          List<ProductoModel> productos = snapshot.data;
          return _PinterestGrid(productos);
        } else {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.amber,
          ));
        }
      },
    );
  }
}

class _PinterestGrid extends StatelessWidget {
  final List<ProductoModel> productos;

  const _PinterestGrid(this.productos);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(
        productos[index],
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(
        2,
        index.isEven ? 3 : 2,
      ),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 6.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final ProductoModel product;

  _PinterestItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.idProducto,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
          onTap: () {
            timeDilation = 2.0;
            Navigator.pushNamed(
              context,
              'ProductoDetalle',
              arguments: product,
            );
          },
          child: FadeInImage(
            image: NetworkImage(product.getImagen()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
