import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/customsilver_appbar.dart';
import 'package:flutter/material.dart';

class ProductoDetallesTienda extends StatefulWidget {
  //const ProductoDetallesTienda({Key key}) : super(key: key);

  @override
  _ProductoDetallesTiendaState createState() => _ProductoDetallesTiendaState();
}

class _ProductoDetallesTiendaState extends State<ProductoDetallesTienda> {
  Icon icon = Icon(Icons.favorite_border);
  final prefs = new PreferenciasUsuario();
  final ProductosProvider productosProvider = new ProductosProvider();
  // if(false){
  //   icon = Icon(Icons.favorite);
  // }

  @override
  Widget build(BuildContext context) {
    final artesanoBloc = Provider.ofArtesano(context);
    final productosBloc = Provider.ofProduc(context);
    final productosBlocCliente = Provider.ofClienteProductos(context);

    final ProductoModel producto = ModalRoute.of(context).settings.arguments;

    productosBlocCliente.obtenerLike(int.parse(producto.idProducto));

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        CustomSilverAppBar(producto: producto),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 20),
            _imagenProducto(producto, context, artesanoBloc, productosBloc),
            _like(producto, productosBlocCliente),
            _descripcion(producto),
          ]),
        )
      ],
    ));
  }

  Widget _imagenProducto(ProductoModel productoModel, BuildContext context,
      ArtesanoBloc bloc, ProductosBloc blocP) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: productoModel.idProducto,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(productoModel.getImagen()),
                //height: 150.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            productoModel.producto,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Categoría: ' + productoModel.categoria,
            style: Theme.of(context).textTheme.subtitle1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.attach_money),
              Text(productoModel.precio.toString()),
              SizedBox(
                width: 60,
              ),
              Text('Disponibilidad'),
              (productoModel.disponibilidad == 1)
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    )
                  : Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 40,
                    ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _descripcion(ProductoModel productoModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
      child: Text(
        productoModel.descripcion,
        textAlign: TextAlign.justify,
        // style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _like(ProductoModel productoModel, ProductosClienteBloc bloc) {
    //final ProductosProvider productosProvider= new ProductosProvider();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Me gusta:'),
        // SizedBox(width: 2),
        (productoModel.tieneLike == 1)
            ? IconButton(
                icon: Icon(Icons.favorite, size: 40),
                color: Colors.purple,
                onPressed: () {
                  setState(() {
                    productoModel.tieneLike = 0;
                    bloc.quitarLike(
                        prefs.idCliente, int.parse(productoModel.idProducto));
                    // bloc.obtenerLike(int.parse(productoModel.idProducto));
                    // setState(() {
                    //  bloc.obtenerLike(int.parse(productoModel.idProducto));
                    // });
                    //numeroLike(productoModel);
                  });
                },
              )
            : IconButton(
                icon: Icon(Icons.favorite_border, size: 40),
                color: Colors.purple,
                onPressed: () {
                  setState(() {
                    productoModel.tieneLike = 1;
                    bloc.darLike(
                        prefs.idCliente, int.parse(productoModel.idProducto));
                    // setState(() {
                    //bloc.obtenerLike(int.parse(productoModel.idProducto));
                    // });
                    //numeroLike(productoModel);
                  });
                },
              ),
        SizedBox(
          width: 30,
        ),

        FutureBuilder(
          future: productosProvider
              .getLikesdeProducto(int.parse(productoModel.idProducto)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text(
                'A ${snapshot.data.toString()} personas mas\n les gusta esta artesanía',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
