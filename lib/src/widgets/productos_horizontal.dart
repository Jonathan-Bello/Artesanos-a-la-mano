import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';

class ProductosHorizontal extends StatelessWidget {
  //const ProductosHorizontal({Key key}) : super(key: key);

  final List<ProductoModel> produtos;
  final String ruta;
  //final Function siguientePagina;

  ProductosHorizontal({@required this.produtos, @required this.ruta
      // @required
      // this.siguientePagina
      });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
    //keepPage: false
  );

  @override
  Widget build(BuildContext context) {
    //obtenego las dimensiones de la pagina
    final _screenSize = MediaQuery.of(context).size;

    // _pageController.addListener((){
    //   if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
    //     siguientePagina();
    //   }
    // });.
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        _pageController.position.animateTo(
          _pageController.position.maxScrollExtent - _screenSize.width * 0.35,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }
      if (_pageController.position.pixels ==
          _pageController.position.minScrollExtent) {
        _pageController.position.animateTo(
          _screenSize.width * 0.3,
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }
    });

    return Container(
      height: 200, //_screenSize.height*0.22,
      child: PageView.builder(
        pageSnapping: false,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        //children: _tarjetas(),
        itemCount: produtos.length,
        itemBuilder: (context, i) {
          return _crearTarjeta(produtos[i], context);
        },
      ),
    );
  }

  Widget _crearTarjeta(ProductoModel producto, BuildContext context) {
    //producto.idProducto = producto.idProducto+'-Hori';
    //print(idTagProducto);

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: producto.idProducto,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(producto.getImagen(), scale: 80),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
                // child: CachedNetworkImage(
                //   imageUrl: producto.getImagen(),
                //   imageBuilder: (context, imageProvider) => Container(
                //     height: 160,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: imageProvider,
                //           fit: BoxFit.cover,
                //           // colorFilter:
                //           //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                //       ),
                //     ),
                //   ),
                //   //filterQuality: FilterQuality.low,
                //   placeholder: (context, url) => Container(child: Image.asset('assets/img/no-image.jpg'),),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              producto.producto,
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    //final ProductosProvider productosProvider= new ProductosProvider();
    //productosProvider.getLikesdeProducto(int.parse(producto.idProducto));
    // List s;
    // s[0]=producto;
    // s[1]=2;

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        final ProductosClienteBloc bloc = new ProductosClienteBloc();
        bloc.obtenerLike(int.parse(producto.idProducto));
        timeDilation = 2.0;
        Navigator.pushNamed(
          context,
          ruta,
          arguments: producto,
        );
      },
    );
  }

  // List<Widget> _tarjetas(){
  //   return produtos.map((producto){
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: <Widget>[
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: FadeInImage(
  //               placeholder: AssetImage('assets/img/loading.gif'),
  //               image: NetworkImage(producto.getImagen()),
  //               fit: BoxFit.cover,
  //               height: 160.0,
  //               ),
  //             ),
  //             SizedBox(height: 5.0,),
  //             Text(
  //               producto.producto,
  //               overflow: TextOverflow.ellipsis
  //               //style: Theme.of(context),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }).toList();

  // }
}
