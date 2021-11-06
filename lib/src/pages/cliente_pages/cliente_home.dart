import 'package:artesanos_a_la_mano/src/widgets/pinterest_grid.dart';
import 'package:flutter/material.dart';
import 'package:artesanos_a_la_mano/src/widgets/fondos_widgets.dart';
import 'package:artesanos_a_la_mano/src/bloc/municipios_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/productoC_bloc.dart';
import 'package:artesanos_a_la_mano/src/bloc/provider_bloc.dart';
import 'package:artesanos_a_la_mano/src/models/producto_model.dart';
import 'package:artesanos_a_la_mano/src/providers/productos_provider.dart';
import 'package:artesanos_a_la_mano/src/share_prefs/preferencias_usuario.dart';
import 'package:artesanos_a_la_mano/src/widgets/card_swiper_widget.dart';
import 'package:artesanos_a_la_mano/src/widgets/drawer_cliente.dart';
import 'package:artesanos_a_la_mano/src/widgets/productos_horizontal.dart';
import 'package:artesanos_a_la_mano/src/search/search_delegate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClienteHome extends StatelessWidget {
  //const ClienteHome({Key key}) : super(key: key);
  final productosProvider = new ProductosProvider();

  final prefs = new PreferenciasUsuario();

  final btnStyle = ButtonStyle(
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = "ClienteHome";
    final municipiosBloc = Provider.ofMunicipios(context);
    final productosBloc = Provider.ofClienteProductos(context);
    productosBloc.cargarProductosRecientes(prefs.idCliente);
    productosBloc.cargarProductosAleatorios(3, prefs.idCliente);

    Future<bool> _vaciarStream() async {
      productosBloc.changeStreamRecientes(null);
      productosBloc.changeStreamAleatorios(null);
      return true;
    }

    return WillPopScope(
      onWillPop: _vaciarStream,
      child: Stack(
        children: <Widget>[
          FondoCliente(),
          Scaffold(
            drawer: DrawerCliente(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'Inicio',
                style: TextStyle(
                  // color: Colors.brown,
                  fontStyle: FontStyle.italic,
                  wordSpacing: 5.0,
                  fontSize: 30.0,
                ),
              ),
              centerTitle: true,
              flexibleSpace: FondoClienteBar(),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  footer(productosBloc),
                  categorias(context, productosBloc),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: CrearPinterestGrid(),
                  ),
                  regiones(context, municipiosBloc),
                  snipperProductos(productosBloc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget snipperProductos(ProductosClienteBloc bloc) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: StreamBuilder(
        stream: bloc.productosAleatorios,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            List<ProductoModel> productos = snapshot.data;
            return CardSwiper(
              productos: productos,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget snipperProductosF() {
    return FutureBuilder(
      future: productosProvider.getProductosAleatorios(4, prefs.idCliente),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          List<ProductoModel> productos = snapshot.data;
          return CardSwiper(
            productos: productos,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget footer(ProductosClienteBloc bloc) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'Recientes',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream:
                bloc.productosRecientes, //peliculasProvider.popularesStream ,
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductoModel>> snapshot) {
              if (snapshot.hasData) {
                List<ProductoModel> productos = snapshot.data;
                return ProductosHorizontal(
                  produtos: productos,
                  ruta: 'ProductoDetalle',
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget ffooter(BuildContext context) {
    //final _screenSize= MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      //height: _screenSize.height*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.black,
            padding: EdgeInsets.only(left: 20.0),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'Lo nuevo',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FutureBuilder(
            future: productosProvider.getProductosRecientes(prefs.idCliente),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductoModel>> snapshot) {
              if (snapshot.hasData) {
                List<ProductoModel> productos = snapshot.data;
                return ProductosHorizontal(
                  produtos: productos,
                  ruta: 'ProductoDetalle',
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ));
              }
            },
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  Widget categorias(BuildContext context, ProductosClienteBloc bloc) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: size.width * .90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
            spreadRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          categoriasBoton(context, bloc),
          ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.gift),
              label: Container(
                child: Text(
                  'Varios',
                  textAlign: TextAlign.center,
                ),
                width: 100,
              ),
              style: btnStyle,
              onPressed: () {
                bloc.cargarProductosCategoria('Varios', prefs.idCliente);
                Navigator.pushNamed(context, 'ListadoCategoria',
                    arguments: 'Varios');
              }),
        ],
      ),
    );
  }

  Widget categoriasBoton(context, ProductosClienteBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            ElevatedButton.icon(
                icon: Icon(Icons.free_breakfast),
                label: Container(
                  child: Text(
                    'Cerámica',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Cerámica', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Cerámica');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.tree),
                label: Container(
                  child: Text(
                    'Madera',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Madera', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Madera');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.glassMartini),
                label: Container(
                  child: Text(
                    'Mármol, Piedra y Vidrio',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria(
                      'Mármol, Piedra y Vidrio', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Mármol, Piedra y Vidrio');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(Icons.watch),
                label: Container(
                  child: Text(
                    'Metal',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Metal', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Metal');
                }),
            SizedBox(height: 5),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: <Widget>[
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.mortarPestle),
                label: Container(
                  child: Text(
                    'Barro',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Barro', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Barro');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.horse),
                label: Container(
                  child: Text(
                    'Piel y Cuero',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria(
                      'Piel y Cuero', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Piel y Cuero');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.tshirt),
                label: Container(
                  child: Text(
                    'Textil',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Textil', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Textil');
                }),
            SizedBox(height: 5),
            ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.sketch),
                label: Container(
                  child: Text(
                    'Joyería',
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarProductosCategoria('Joyería', prefs.idCliente);
                  Navigator.pushNamed(context, 'ListadoCategoria',
                      arguments: 'Joyería');
                }),
            SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  Widget regiones(BuildContext context, MunicipiosBloc bloc) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.symmetric(vertical: 30.0),
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
        ],
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Búsqueda por\n Regiones',
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          regionesBoton(context, bloc),
          ElevatedButton(
              child: Container(
                child: Center(
                    child: Text(
                  'VII - Tehuacán Y Sierra Negra',
                  textAlign: TextAlign.center,
                )),
                width: 110,
              ),
              style: btnStyle,
              onPressed: () {
                bloc.cargarMuncipiosRegion(7);
                Navigator.pushNamed(context, 'ListadoMunicipios', arguments: 7);
              }),
        ],
      ),
    );
  }

  Widget regionesBoton(BuildContext context, MunicipiosBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            ElevatedButton(
                child: Container(
                  child: Center(
                      child: Text(
                    'I - Huauchinango',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarMuncipiosRegion(1);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 1);
                }),
            SizedBox(height: 5),
            ElevatedButton(
                child: Container(
                  child: Center(
                      child: Text(
                    'III - Ciudad Serdán',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarMuncipiosRegion(3);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 3);
                }),
            SizedBox(height: 5),
            ElevatedButton(
                child: Container(
                  child: Center(
                      child: Text(
                    'V - Puebla',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarMuncipiosRegion(5);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 5);
                }),
            SizedBox(height: 5),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: <Widget>[
            ElevatedButton(
                child: Container(
                  child: Center(
                      child: Text(
                    'II-Teziutlán',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                style: btnStyle,
                onPressed: () {
                  bloc.cargarMuncipiosRegion(2);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 2);
                }),
            SizedBox(height: 5),
            ElevatedButton(
                style: btnStyle,
                child: Container(
                  child: Center(
                      child: Text(
                    'IV - San Pedro Cholula',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                onPressed: () {
                  bloc.cargarMuncipiosRegion(4);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 4);
                }),
            SizedBox(height: 5),
            ElevatedButton(
                style: btnStyle,
                child: Container(
                  child: Center(
                      child: Text(
                    'VI - Izúcar De Matamoros',
                    textAlign: TextAlign.center,
                  )),
                  width: 110,
                ),
                onPressed: () {
                  bloc.cargarMuncipiosRegion(6);
                  Navigator.pushNamed(context, 'ListadoMunicipios',
                      arguments: 6);
                }),
            SizedBox(height: 5),
          ],
        ),
      ],
    );
  }
}
