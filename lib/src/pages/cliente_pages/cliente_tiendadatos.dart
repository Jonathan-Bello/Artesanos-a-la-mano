import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/artesano_model.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/utils/utils.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:artesanos_a_la_mano/src/widgets/productos_horizontal.dart';
import 'package:flutter/material.dart';

class ClienteTiendaPage extends StatelessWidget {
  //const ClienteTiendaPage({Key key}) : super(key: key);
  // List<String> regiones= municipiosRegionLista();

  @override
  Widget build(BuildContext context) {
    final ArtesanosModel artesano = ModalRoute.of(context).settings.arguments;
    List<String> municipios = municipiosLista();
    final productosBloc = Provider.ofProduc(context);
    final artesanoBloc = Provider.ofArtesano(context);

    Future<bool> _vaciarStream() async {
      productosBloc.changeStreamProductos(null);
      artesanoBloc.changeStreamArtesano(null);
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(artesano, context),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              _artesanoUbicacion(artesano, context, municipios),
              SizedBox(height: 30),
              _artesanoContacto(artesano, context),
              SizedBox(height: 30),
              footer(productosBloc),
              // _descripcion(producto),
              // _crearCasting(pelicula),
            ]),
          )
        ],
      )),
    );
  }

  Widget _crearAppbar(ArtesanosModel artesanosModel, context) {
    //final _screenSize= MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.purple,
      expandedHeight: 100.0,
      floating: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //que se muestre siempre aunque se haga scroll
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          artesanosModel.tienda,
          style: TextStyle(color: Colors.white, fontSize: 15),
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
        background: FondoClienteBar(),
      ),
    );
  }

  Widget _artesanoUbicacion(ArtesanosModel artesanosModel, BuildContext context,
      List<String> municipios) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              width: size.width * .85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.5),
                        spreadRadius: 3.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Ubicación de la Tienda',
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Calle: ${artesanosModel.calle}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Colonia: ' + artesanosModel.colonia,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Referencias: ' + artesanosModel.referencias,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Código Postal: ' + artesanosModel.cP.toString()),
                      SizedBox(
                        width: 40,
                      ),
                      Text('Región: ' + artesanosModel.region.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Municipio: ' +
                        municipios.elementAt(artesanosModel.idMunicipio - 1),
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _artesanoContacto(
      ArtesanosModel artesanosModel, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
              width: size.width * .85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.5),
                        spreadRadius: 3.0)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Datos de contacto',
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Dueño: ${artesanosModel.nombre} ${artesanosModel.apellidos}',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Teléfono: ' + artesanosModel.celular,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Correo: ' + artesanosModel.correo,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget footer(ProductosBloc bloc) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Otros productos de Tienda',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 20.0
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          StreamBuilder(
            stream: bloc.productosStream, //peliculasProvider.popularesStream ,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductoModel>> snapshot) {
              if (snapshot.hasData) {
                List<ProductoModel> productos = snapshot.data;
                return ProductosHorizontal(
                  produtos: productos,
                  ruta: 'ProductoDetallesTienda',
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
